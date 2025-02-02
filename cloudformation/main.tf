

provider "aws" {
  region  = "us-west-1"
#  profile = "mdupont"
}

provider "aws" {
  alias  = "uswest1"
  region  = "us-west-1"
#  profile = "mdupont"
}

provider "aws" {
  alias  = "useast1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "useast2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "eucentral1"
  region = "eu-central-1"
}

provider "aws" {
  alias  = "apsoutheast1"
  region = "ap-southeast-1"
}

variable groq_key {
sensitive=true
}
variable twitter_password {
  sensitive=true
}
variable twitter_user_name {
  sensitive=true
}
variable twitter_mail {
  sensitive=true
}
variable lt_version {
  default = "1"
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
  key    = "zos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer-dev.yaml"  # Replace with your desired file name
  source = "ec2.yml"  # Replace with the path to your template file
}

output "template_url" {
  value = "https://${aws_s3_bucket.template_bucket.bucket_regional_domain_name}/${aws_s3_object.cloudformation_template.key}"
}
module region_useast1 {
    source = "./regional_outpost"
    providers ={        aws = aws.useast1    }
    region = "us-east-1"
}

module region_useast2 {
    source = "./regional_outpost"
    providers ={        aws = aws.useast2    }
    region = "us-east-2"
}

module region_uswest1 {
    source = "./regional_outpost"
    providers ={        aws = aws.uswest1    }
    region = "us-west-1"
}

module region_eucentral1 {
    source = "./regional_outpost"
    providers ={        aws = aws.eucentral1    }
    region = "eu-central-1"
}

module region_apsoutheast1 {
    source = "./regional_outpost"
    providers ={        aws = aws.apsoutheast1    }
    region = "ap-southeast-1"
}

output "regions" {
  value = [
    module.region_useast2.full_template_url,
    module.region_useast1.full_template_url,
    module.region_uswest1.full_template_url,
    module.region_eucentral1.full_template_url,
    module.region_apsoutheast1.full_template_url
  ]
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


## 
resource "aws_cloudformation_stack" "eliza_stack" {
   name = "tine-agent"
   capabilities = [ "CAPABILITY_NAMED_IAM" ]
   template_body = file("ec2.yml")
   parameters = {
     AmiId = module.region_uswest1.ami_id
     GroqKey = var.groq_key
     TwitterPassword= var.twitter_password
     TwitterUserName = var.twitter_user_name 
     TwitterEmail = var.twitter_mail
     LaunchTemplateVersion = var.lt_version
     NameTag = "tine-dev2"
     AgentCodeName = "tine_agent_3"
    }  
 }
