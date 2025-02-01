
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

resource "aws_s3_bucket" "template_bucket" {
  bucket = "zos-solfunmeme-tine-cf-template"  # Replace with your desired bucket name
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "template_bucket_public_access" {
  bucket = aws_s3_bucket.template_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.template_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.template_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "cloudformation_template" {
  bucket = aws_s3_bucket.template_bucket.id
  key    = "zos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer.yaml"  # Replace with your desired file name
  source = "ec2.yml"  # Replace with the path to your template file
}

output "template_url" {
  value = "https://${aws_s3_bucket.template_bucket.bucket_regional_domain_name}/${aws_s3_object.cloudformation_template.key}"
}

# resource "aws_cloudformation_type" "tine" {
#   schema_handler_package = "s3://${aws_s3_bucket.template_bucket.id}/${aws_s3_object.cloudformation_template.key}"
#   type                   = "RESOURCE"
#   type_name              = "ZOS::Solfunmeme::Tine"

# #  logging_config {
# #    log_group_name = aws_cloudwatch_log_group.example.name
# #    log_role_arn   = aws_iam_role.example.arn
# #  }

#   lifecycle {
#     create_before_destroy = true
#   }
# }