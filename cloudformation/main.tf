provider "aws" {
  region  = "us-west-1"
  profile = "mdupont"
}

locals {   ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*" }
data "aws_ami" "ami" { # slow
    most_recent      = true
    name_regex       = "^${local.ami_name}"
  }

resource "aws_cloudformation_stack" "eliza_stack" {
  name = "tine-agent"
  capabilities = [ "CAPABILITY_NAMED_IAM" ]

#  template_body = file("cloudformation.yml")
  template_body = file("ec2.yml")
  parameters = {
      AmiId = data.aws_ami.ami.id
 
   }  
}
