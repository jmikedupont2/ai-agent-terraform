provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

locals {   ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*" }

data "aws_ami" "ami" { # slow
    most_recent      = true
    name_regex       = "^${local.ami_name}"
  }


locals {
  # hard coded to save time , fixme use a caching system
  ami_id =     data.aws_ami.ami.id
}

module "ssm_observer" {
  source = "../../modules/aws/ssm/observability"
  ami_id = local.ami_id
}
 
module "ssm_setup" {
  source = "../../modules/aws/ssm/setup"
  bucket_name = "${var.codename}-session-logs"
  access_log_bucket_name = "${var.codename}-session-access-logs"
  project = "${var.codename}"
 }


 # now after we create the above resources, we can do the following,
 # FIXME need to add dependencies
 module "eliza_server" {
   depends_on = [
    module.ssm_observer #.aws_ssm_parameter.cw_agent_config
  ]
#count = 0
  #aws_account_id = var.account
  aws_account_id  =var.aws_account_id
  region         = var.aws_region
  ssm_region         = var.aws_region
  source         = "../../environments/eliza-agent-api" 
   domain         = var.dns_name
   key_name = "mdupont-deployer-key"
   branch = "feature/arm64_fastembed"
   project = var.codename
    instance_types = ["t4g.small"] # not big enough for building

   repo = "https://github.com/meta-introspector/cloud-deployment-eliza/"
   aws_availability_zones =[
   "${var.aws_region}a",
     "${var.aws_region}b",
     "${var.aws_region}c" # FIXME
   ]

# FIXME not used right now
   spot_max_price= 0.01
  ami_id = local.ami_id #
  name = "${var.codename}"
  tags = { project = "${var.codename}" }
}

