
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "agent_image" {}
variable "tokenizer_image" {}

variable "region" {}
variable "patch" {} # was v3

# resource "aws_s3_bucket" "template_bucket" {
#   count = 0 # dont create now
#   bucket        = "zos-solfunmeme-tine-cf-template-${var.region}" # Replace with your desired bucket name
#   force_destroy = true
# }

data "aws_s3_bucket" "template_bucket" {
  bucket = "zos-solfunmeme-tine-cf-template-${var.region}" # Replace with your desired bucket name

}

# resource "aws_s3_bucket_public_access_block" "template_bucket_public_access" {
#  count = 0 # dont create now
#   bucket                  = aws_s3_bucket.template_bucket.id
#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_policy" "allow_public_read" {
#   count = 0 # dont create now
#   bucket = aws_s3_bucket.template_bucket.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource  = "${aws_s3_bucket.template_bucket.arn}/*"
#       }
#     ]
#   })
# }

resource "aws_s3_object" "cloudformation_template" {
  bucket = data.aws_s3_bucket.template_bucket.id
  key    = "zos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer-dev-${var.patch}.yaml" # Replace with your desired file name
  source = "cloudformation.yml"                                                                                         # Replace with the path to your template file
  etag   = filemd5("cloudformation.yml")                                                                                # Update when the file changes
}


data "aws_ami" "ami" { # slow
  most_recent = true
  owners      = [679593333241] # ubuntu
  name_regex  = "^${local.ami_name}"
}

locals {
  ami_name     = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*"
  template_url = "https://${data.aws_s3_bucket.template_bucket.bucket_regional_domain_name}/${aws_s3_object.cloudformation_template.key}"
}

locals {
  cf_template_url = "https://${var.region}.console.aws.amazon.com/cloudformation/home?region=${var.region}#/stacks/quickcreate?templateURL=${local.template_url}&stackName=zos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer&param_S3BucketPattern=tine_agent_*&param_GroqKey=&param_TokenizerImage=${var.tokenizer_image}&param_TwitterPassword=&param_NameTag=tine-dev&param_AgentCodeName=tine_agent_4&param_SSMParameterPattern=tine_agent_*&param_TwitterUserName=&param_LaunchTemplateVersion=1&param_TwitterEmail=&param_AgentImage=${var.agent_image}&param_AmiId=${data.aws_ami.ami.id}"
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
