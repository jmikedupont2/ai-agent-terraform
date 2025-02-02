provider "aws" {
  region = "us-west-1"
  #profile = "ai-token-team"
  profile = "default"
}

locals {
  dns     = "aitokenteam.com" # fixme
  region  = "us-west-1"
  project = "ai-token-team" # dont change
}

module "ssm_observer" {
  source = "../../modules/aws/ssm/observability"
  ami_id = data.aws_ami.ami.id
}

module "ssm_setup" {
  source                 = "../../modules/aws/ssm/setup"
  bucket_name            = "${local.project}-session-logs"
  access_log_bucket_name = "${local.project}-ssm-access-logs"
  project                = local.project
}

locals {
  ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-*"
}
data "aws_ami" "ami" { # slow
  most_recent = true
  owners      = ["679593333241"]
  name_regex  = "^${local.ami_name}"
}

module "eliza_server" {
  #count = 0
  #aws_account_id = local.account
  aws_account_id = var.aws_account_id
  region         = local.region
  source         = "../../environments/eliza-agent-api/" # FIXME rename
  domain         = local.dns
  ami_id         = data.aws_ami.ami.id
  name           = local.project
  project        = local.project
  key_name       = "ai-token-deployer-key"
  tags           = { project = local.project }

  branch         = "feature/AI_Token_Team"
  spot_max_price = 0.028
  instance_types = [
    "t3a.small",
    #    "t3.small",
    #    "t2.small", 
    #    "t3.medium"  # works for sure

  ]
  repo = "https://github.com/meta-introspector/cloud-deployment-eliza/"
  aws_availability_zones = ["us-west-1a",
    #"us-west-1b",
  "us-west-1c"]
}
