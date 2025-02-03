

provider "aws" {
  region = "us-west-1"
  #  profile = "mdupont"
}

data "aws_regions" "all" {
  all_regions = true
}

locals {
  all_regions = [
    "af-south-1",
    "ap-east-1",
    "ap-northeast-1",
    "ap-northeast-2",
    "ap-northeast-3",
    "ap-south-1",
    "ap-south-2",
    "ap-southeast-1",
    "ap-southeast-2",
    "ap-southeast-3",
    "ap-southeast-4",
    "ap-southeast-5",
    "ap-southeast-7",
    "ca-central-1",
    "ca-west-1",
    "eu-central-1",
    "eu-central-2",
    "eu-north-1",
    "eu-south-1",
    "eu-south-2",
    "eu-west-1",
    "eu-west-2",
    "eu-west-3",
    "il-central-1",
    "me-central-1",
    "me-south-1",
    "mx-central-1",
    "sa-east-1",
    "us-east-1",
    "us-east-2",
    "us-west-1",
    "us-west-2",
  ]
}

output all_regions {
  value = data.aws_regions.all
}

module genprovider {
  for_each = data.aws_regions.all
  source = "./genprovider"
  regions = [each.key]
}

output "gen_regions" {
  value = module.genprovider
}

provider "aws" {
  alias  = "uswest1"
  region = "us-west-1"
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

variable "groq_key" {
  sensitive = true
}
variable "twitter_password" {
  sensitive = true
}
variable "twitter_user_name" {
  sensitive = true
}
variable "twitter_mail" {
  sensitive = true
}
variable "lt_version" {
  default = "1"
}

module "region_useast1" {
  source    = "./regional_outpost"
  providers = { aws = aws.useast1 }
  region    = "us-east-1"
}

module "region_useast2" {
  source    = "./regional_outpost"
  providers = { aws = aws.useast2 }
  region    = "us-east-2"
}

module "region_uswest1" {
  source    = "./regional_outpost"
  providers = { aws = aws.uswest1 }
  region    = "us-west-1"
}

module "region_eucentral1" {
  source    = "./regional_outpost"
  providers = { aws = aws.eucentral1 }
  region    = "eu-central-1"
}

module "region_apsoutheast1" {
  source    = "./regional_outpost"
  providers = { aws = aws.apsoutheast1 }
  region    = "ap-southeast-1"
}

output "regions" {
  value = [
    module.region_useast2.full_html_url,
    module.region_useast1.full_html_url,
    module.region_uswest1.full_html_url,
    module.region_eucentral1.full_html_url,
    module.region_apsoutheast1.full_html_url
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
  count = 0 # turn off now now
  name          = "tine-agent"
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  template_body = file("ec2.yml")
  parameters = {
    AmiId                 = module.region_uswest1.ami_id
    GroqKey               = var.groq_key
    TwitterPassword       = var.twitter_password
    TwitterUserName       = var.twitter_user_name
    TwitterEmail          = var.twitter_mail
    LaunchTemplateVersion = var.lt_version
    NameTag               = "tine-dev2"
    AgentCodeName         = "tine_agent_3"
  }
}

resource "local_file" "items_to_html" {
  content  = join("\n", [
    module.region_useast2.full_html_url,
    module.region_useast1.full_html_url,
    module.region_uswest1.full_html_url,
    module.region_eucentral1.full_html_url,
    module.region_apsoutheast1.full_html_url
  ])
  filename = "installer.md"
}

