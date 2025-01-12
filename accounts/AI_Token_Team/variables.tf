variable "project_name" {
  type    = string
  default = "ai-token-team"
}

variable "profile" {
  type    = string
  default = "ai-token-team"
}

variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "aws_account_id" {
  type    = string
  default = "699475930706"
}

variable "iam_user" {
  type    = string
  default = "aitokenteam"
}

variable "lock_resource" {
  type    = string
  default = "terraform/state/lock"
}

variable "partition" {
  type    = string
  default = "aws"
}

variable "logs_resource" {
  type    = string
  default = "aws_logs"
}

variable "permissions_check" {
  type    = string
  default = "config-permissions-check"
}

variable "delivery_service" {
  type    = string
  default = "delivery.logs.amazonaws.com"
}

variable "logging_service" {
  type    = string
  default = "logging.s3.amazonaws.com"
}
