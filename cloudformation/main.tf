
provider "aws" {
  region  = "us-west-1"
#  profile = "mdupont"
}

variable groq_key {}
variable twitter_password {}
variable twitter_user_name {}
variable twitter_mail {}
variable lt_version {
  default = "1"
}
locals {   ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*" }
data "aws_ami" "ami" { # slow
    most_recent      = true
    owners          = [ 679593333241 ]
    name_regex       = "^${local.ami_name}"
  }

resource "aws_cloudformation_stack" "eliza_stack" {
  name = "tine-agent"
  capabilities = [ "CAPABILITY_NAMED_IAM" ]

#  template_body = file("cloudformation.yml")
  template_body = file("ec2.yml")
  parameters = {
    AmiId = data.aws_ami.ami.id
    GroqKey = var.groq_key
    TwitterPassword= var.twitter_password
    TwitterUserName = var.twitter_user_name 
    TwitterEmail = var.twitter_mail
    LaunchTemplateVersion = var.lt_version
   }  
}
