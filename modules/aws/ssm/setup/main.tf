variable bucket_name{}
variable access_log_bucket_name{}
variable project{}
module "ssm" {
  #  source                    = "bridgecrewio/session-manager/aws"
  #  version                   = "0.4.2"
  source                   = "git::https://github.com/jmikedupont2/terraform-aws-session-manager.git?ref=master"
  bucket_name              = var.bucket_name
  access_log_bucket_name   = var.access_log_bucket_name
  enable_log_to_s3         = true
  enable_log_to_cloudwatch = true
  tags                     = { project = var.project }
  #linux_shell_profile      = "date"
}

#https://github.com/gazoakley/terraform-aws-session-manager-settings


resource "aws_cloudwatch_log_group" "app_signals" {
  for_each          = toset(["ec2", "eks", "generic", "k8s"])
  name              = "/aws/appsignals/${each.key}"
  retention_in_days = 30
  kms_key_id        = "arn:aws:kms:us-east-2:916723593639:key/cc8e1ee7-a05b-4642-bd81-ba5548635590"
}

resource "aws_cloudwatch_log_group" "app_signals2" {
  for_each          = toset(["data"])
  name              = "/aws/application-signals/${each.key}"
  retention_in_days = 30
  kms_key_id        = "arn:aws:kms:us-east-2:916723593639:key/cc8e1ee7-a05b-4642-bd81-ba5548635590"
}

