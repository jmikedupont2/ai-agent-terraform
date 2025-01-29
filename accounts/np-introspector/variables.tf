variable "dns_name" {
  type    = string
  description =  "DNS name not used yet by default"
  default = "np.introspector.meme"
}

variable "aws_region" {
  type    = string
  default = "ap-south-2"
}

variable "aws_account_id" {
  type    = string
  default = "084375543224"
}

variable "iam_user" {
  type    = string
  default = "np_introspector"
}

variable codename {
  default = "hanumen"
}

# dont expose PII
#variable "user_name" {
#  type    = string
#  default = ""
#}



