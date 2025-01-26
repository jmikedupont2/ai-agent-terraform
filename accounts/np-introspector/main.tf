provider "aws" {
  region  = "ap-south-1"
  profile = "np-introspector"
}

locals {
  # hard coded to save time , fixme use a caching system
  # ami_id = "ami-0325b9a2dfb474b2d" for ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-*" }
  ami_id = "ami-0e44962f5c9a2baab"
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
   #count = 0
  #aws_account_id = var.account
  aws_account_id  =var.aws_account_id
  region         = var.region
  source         = "../../environments/eliza-agent-api" 
   domain         = var.dns
   key_name = "mdupont-deployer-key"
   branch = "feature/arm64_fastembed"
   project = var.codename
    instance_types = ["t4g.small"] # not big enough for building

   repo = "https://github.com/meta-introspector/cloud-deployment-eliza/"
   aws_availability_zones =[
   "${var.region}a",
     "${var.region}b",
     "${var.region}c"
   ]

# FIXME not used right now
   spot_max_price= 0.01
  ami_id = local.ami_id #data.aws_ami.ami.id
  name = "${var.codename}"
  tags = { project = "${var.codename}" }
}

