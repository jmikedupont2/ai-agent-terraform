# generic runbook uploader
# expects "cloudformation-${var.runbook}.yml" to exist
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "region" {}
variable "patch" {} # was v3
variable "runbook" {
  description = "name of the runbook"
}

data "aws_s3_bucket" "template_bucket" {
  # DONT CHANGE THIS we keep the old bukcet
  bucket = "zos-solfunmeme-tine-cf-template-${var.region}" # Replace with your desired bucket name

}

resource "aws_s3_object" "cloudformation_template" {
  bucket = data.aws_s3_bucket.template_bucket.id
  key    = "zos-solfunmeme-runbook-${var.runbook}-${var.patch}.yaml"
  source = "cloudformation-${var.runbook}.yml"
  etag   = filemd5("cloudformation-${var.runbook}.yml")
}

locals {
  template_url = "https://${data.aws_s3_bucket.template_bucket.bucket_regional_domain_name}/${aws_s3_object.cloudformation_template.key}"
}

locals {
  cf_template_url = "https://${var.region}.console.aws.amazon.com/cloudformation/home?region=${var.region}#/stacks/quickcreate?templateURL=${local.template_url}&stackName=zos-solfunmeme-${var.runbook}-stack-template}"
  image_url       = "![Launch ${var.region} Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)"
}

output "full_template_url" {
  value = local.template_url
}

output "full_html_url" {
  value = "* ${var.region} [${local.image_url}](${local.cf_template_url})"
}
