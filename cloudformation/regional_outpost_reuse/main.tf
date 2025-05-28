
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "region" {}
variable "patch" {} # was v3

data "aws_s3_bucket" "template_bucket" {
  bucket = "zos-solfunmeme-tine-cf-template-${var.region}" # Replace with your desired bucket name
}

resource "aws_s3_object" "cloudformation_template_S3" {
  bucket = data.aws_s3_bucket.template_bucket.id
  key    = "zos-solfunmeme-introspector-solana-stack-template-one-click-installer-dev-${var.patch}.yaml" # Replace with your desired file name
  source = "cloudformation.yml"                                                                                         # Replace with the path to your template file
  etag   = filemd5("cloudformation.yml")                                                                                # Update when the file changes
}

variable ami_name {
  default = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*"
}

data "aws_ami" "ami" { # slow
  most_recent = true
  owners      = [679593333241] # ubuntu
  name_regex  = "^${var.ami_name}"
}

locals {  
  template_url = "https://${data.aws_s3_bucket.template_bucket.bucket_regional_domain_name}/${aws_s3_object.cloudformation_template_S3.key}"
}

locals {
  cf_template_url = "https://${var.region}.console.aws.amazon.com/cloudformation/home?region=${var.region}#/stacks/quickcreate?templateURL=${local.template_url}&stackName=zos-solfunmeme-solana-stack-template-one-click-installer${var.patch}&param_AgentCodeName=tine_agent_4&param_AmiId=${data.aws_ami.ami.id}"
  image_url       = "![Launch ${var.region} Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)"
}

output "full_template_url" {
  value = local.template_url
}

output "full_html_url" {
  value = "* ${var.region} [${local.image_url}](${local.cf_template_url})"
}

output "ami_id" {
  value = data.aws_ami.ami.id
}
