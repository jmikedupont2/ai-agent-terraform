provider "aws" {
  region  = "us-east-2"
  profile = "mdupont"
}

provider "aws" {
  alias = "us_east_1"
  region  = "us-east-1"
  profile = "mdupont"
}

#variable "google_oauth_client_secret" {}
#variable "google_oauth_client_id" {} 

locals {

  dns      = "eliza.introspector.meme"
  region   = "us-east-2"
}
  
# module ses {
#   verify_dkim=true
#   domain="introspector.meme" # put the mail at the top level
#   #verify_domain =true
#   verify_domain =false # not on aws
#   group_name="introspector"
#   source = "../../environments/swarms-aws-agent-api/dev/us-east-1/components/ses"
# }

# module ses_verification {
#   verify_dkim=true
#   domain="introspector.meme" # put the mail at the top level
#   #verify_domain =true
#   verify_domain =false # not on aws
#   group_name="introspector"
#   source = "../../environments/swarms-aws-agent-api/dev/us-east-1/components/ses_verify"
# }

#module cognito {

#  myemail ="jmdupont"
#  mydomain ="introspector"
#  mydomain_suffix = "meme"
#  #../../../17/
#  aws_region = var.aws_region
#  env={
#    region = var.aws_region
#    profile = var.profile
#  }
#  source = "../../environments/swarms-aws-agent-api/dev/us-east-1/components/cognito_user_pool"
  #source = "~/2024/12/17/cognito/terraform-aws-cognito-user-pool/examples/complete/"
  #source = "git::https://github.com/meta-introspector/terraform-aws-cognito-user-pool.git?ref=feature/meta-meme"
#  google_oauth_client_secret=var.google_oauth_client_secret
#  google_oauth_client_id=var.google_oauth_client_id
#}
#output cognito{
#  value = module.cognito
#  sensitive = true
#}


#locals {   ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*" }
# data "aws_ami" "ami" { # slow
#    most_recent      = true
#    name_regex       = "^${local.ami_name}"
#  }

locals {
  # hard coded to save time , fixme use a caching system
  # ami_id = "ami-0325b9a2dfb474b2d" for ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*" }
  ami_id = "ami-0e44962f5c9a2baab"
}

module "ssm_observer" {
  source = "../../modules/aws/ssm/observability"
  #ami_id = data.aws_ami.ami.id
  ami_id = local.ami_id
  
  aws_region = var.aws_region
}
 
module "ssm_setup" {
  source = "../../modules/aws/ssm/setup"
  bucket_name = "tine-session-logs"
  access_log_bucket_name = "tine-session-access-logs"
  project = "tine"
 }


 # now after we create the above resources, we can do the following,
 # FIXME need to add dependencies
 module "eliza_server" {
   #count = 0
  #aws_account_id = local.account
  aws_account_id  =var.aws_account_id
   region         = local.region
   ssm_region         = local.region
  source         = "../../environments/eliza-agent-api" 
   domain         = local.dns
#   key_name = "mdupont-deployer-key"
   branch = "feature/arm64_fastembed"
   project = "tine"
    instance_types = ["t4g.small"] # not big enough for building
   #instance_types = ["t4g.medium"]
   repo = "https://github.com/meta-introspector/cloud-deployment-eliza/"
   aws_availability_zones =["us-east-2a",
     "us-east-2b",
     "us-east-2c"
   ]

   depends_on = [
   #    module.ssm_setup.
   #│ arn:aws:ssm:ap-south-2:084375543224:parameter/cloudwatch-agent/config/details
    module.ssm_observer #.aws_ssm_parameter.cw_agent_config,
    #    module.ssm_observer.aws_ssm_parameter.cw_agent_config_details
  ]

   spot_max_price= 0.01
  ami_id = local.ami_id #data.aws_ami.ami.id
  name = "eliza"
  tags = { project = "eliza" }
}


locals {
  dev_region ="us-east-1"
}

locals {   ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*" }
data "aws_ami" "dev_ami" { # slow
  most_recent      = true
  provider = aws.us_east_1
  name_regex       = "^${local.ami_name}"
}

locals {
  dev_ami_id = data.aws_ami.dev_ami.id
}

module "ssm_observer2" {
  aws_region = local.dev_region
  source = "../../modules/aws/ssm/observability"
  #ami_id = data.aws_ami.ami.id
  ami_id = local.ami_id
    providers = {
    aws= aws.us_east_1
  }

}

module "eliza_test_server" {

     depends_on = [
   #    module.ssm_setup.
   #│ arn:aws:ssm:ap-south-2:084375543224:parameter/cloudwatch-agent/config/details
    module.ssm_observer2 #.aws_ssm_parameter.cw_agent_config,
    #    module.ssm_observer.aws_ssm_parameter.cw_agent_config_details
  ]

  
  aws_account_id  =var.aws_account_id
  region         = local.dev_region
  ssm_region         = local.dev_region
  providers = {
    aws= aws.us_east_1
  }
  source         = "../../environments/eliza-agent-api" 
  domain         = local.dns
#   key_name = "mdupont-deployer-key"
   branch = "feature/systemd-parameters"
   project = "tine-dev"
    instance_types = ["t4g.small"] # 
   repo = "https://github.com/meta-introspector/cloud-deployment-eliza/"
   aws_availability_zones =["${local.dev_region}a","${local.dev_region}b",
   			  "${local.dev_region}c"
   ]
   spot_max_price= 0.01
  ami_id = local.dev_ami_id #data.aws_ami.ami.id
  name = "eliza_dev"
  tags = { project = "eliza_dev" }
}

#module "codebuild" {
#  source         = "./codebuild"
#}
