provider "aws" {
  region  = "us-west-1"
  profile = "ai-token-team"
}

locals {
  dns      = "aitokenteam.com" # fixme
  region   = "us-west-1"
  project  = "ai-token-team" # dont change
}

locals {
  # hard coded to save time , fixme use a caching system
#  ami_id = "ami-0325b9a2dfb474b2d"
}
module "ssm_observer" {
  source = "../../modules/aws/ssm/observability"
  #ami_id = data.aws_ami.ami.id
  ami_id = local.ami_id
}
 
module "ssm_setup" {
  source = "../../modules/aws/ssm/setup"
  bucket_name = "${local.project}session-logs"
  access_log_bucket_name = "${local.project}-session-access-logs"
  project = local.project
 }


 module "eliza_server" {
   #count = 0
   #aws_account_id = local.account
   aws_account_id  =var.aws_account_id
   region         = local.region
   source         = "../../environments/swarms-aws-agent-api/dev/us-east-1" # FIXME rename
   domain         = local.dns
   ami_id = local.ami_id #data.aws_ami.ami.id
   name = local.project
   key_name=  = "ai-token-deployer-key"
   tags = { project = local.project }
   ami_name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}
