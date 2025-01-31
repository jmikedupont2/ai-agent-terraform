
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
