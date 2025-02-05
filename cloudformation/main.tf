# default
provider "aws" {
  region = "us-west-1"
  #  profile = "mdupont"
}

## generated regions

provider "aws" {
  alias  = "afsouth1"
  region = "af-south-1"
}

provider "aws" {
  alias  = "apeast1"
  region = "ap-east-1"
}

provider "aws" {
  alias  = "apnortheast1"
  region = "ap-northeast-1"
}

provider "aws" {
  alias  = "apnortheast2"
  region = "ap-northeast-2"
}

provider "aws" {
  alias  = "apnortheast3"
  region = "ap-northeast-3"
}

provider "aws" {
  alias  = "apsouth1"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "apsouth2"
  region = "ap-south-2"
}

provider "aws" {
  alias  = "apsoutheast1"
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "apsoutheast2"
  region = "ap-southeast-2"
}

provider "aws" {
  alias  = "apsoutheast3"
  region = "ap-southeast-3"
}

provider "aws" {
  alias  = "apsoutheast4"
  region = "ap-southeast-4"
}

provider "aws" {
  alias  = "apsoutheast5"
  region = "ap-southeast-5"
}


provider "aws" {
  alias  = "apsoutheast7"
  region = "ap-southeast-7"
}

provider "aws" {
  alias  = "cacentral1"
  region = "ca-central-1"
}

provider "aws" {
  alias  = "cawest1"
  region = "ca-west-1"
}

provider "aws" {
  alias  = "eucentral1"
  region = "eu-central-1"
}

provider "aws" {
  alias  = "eucentral2"
  region = "eu-central-2"
}

provider "aws" {
  alias  = "eunorth1"
  region = "eu-north-1"
}

provider "aws" {
  alias  = "eusouth1"
  region = "eu-south-1"
}

provider "aws" {
  alias  = "eusouth2"
  region = "eu-south-2"
}

provider "aws" {
  alias  = "euwest1"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "euwest2"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "euwest3"
  region = "eu-west-3"
}

provider "aws" {
  alias  = "ilcentral1"
  region = "il-central-1"
}

provider "aws" {
  alias  = "mecentral1"
  region = "me-central-1"
}

provider "aws" {
  alias  = "mesouth1"
  region = "me-south-1"
}

provider "aws" {
  alias  = "mxcentral1"
  region = "mx-central-1"
}

provider "aws" {
  alias  = "saeast1"
  region = "sa-east-1"
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
  alias  = "uswest1"
  region = "us-west-1"

}
provider "aws" {
  alias  = "uswest2"
  region = "us-west-2"
}


module "region_apnortheast1" {
  source    = "./regional_outpost"
  providers = { aws = aws.apnortheast1 }
  region    = "ap-northeast-1"
}

module "region_apnortheast2" {
  source    = "./regional_outpost"
  providers = { aws = aws.apnortheast2 }
  region    = "ap-northeast-2"
}

module "region_apnortheast3" {
  source    = "./regional_outpost"
  providers = { aws = aws.apnortheast3 }
  region    = "ap-northeast-3"
}

module "region_apsouth1" {
  source    = "./regional_outpost"
  providers = { aws = aws.apsouth1 }
  region    = "ap-south-1"
}


#module "region_apsouth2" { source    = "./regional_outpost" providers = { aws = aws.apsouth2 } region    = "ap-south-2"}

module "region_apsoutheast1" {
  source    = "./regional_outpost"
  providers = { aws = aws.apsoutheast1 }
  region    = "ap-southeast-1"
}


module "region_apsoutheast2" {
  source    = "./regional_outpost"
  providers = { aws = aws.apsoutheast2 }
  region    = "ap-southeast-2"
}


#module "region_apsoutheast3" { source    = "./regional_outpost" providers = { aws = aws.apsoutheast3 } region    = "ap-southeast-3"}

#module "region_apsoutheast4" { source    = "./regional_outpost" providers = { aws = aws.apsoutheast4 } region    = "ap-southeast-4"}

# missing ami
#module "region_apsoutheast5" {
#  source    = "./regional_outpost"
#  providers = { aws = aws.apsoutheast5 }
#  region    = "ap-southeast-5"
#}

#module "region_apsoutheast7" {  source    = "./regional_outpost"  providers = { aws = aws.apsoutheast7 }  region    = "ap-southeast-7"}

module "region_cacentral1" {
  source    = "./regional_outpost"
  providers = { aws = aws.cacentral1 }
  region    = "ca-central-1"
}

#module "region_cawest1" {  source    = "./regional_outpost"  providers = { aws = aws.cawest1 }  region    = "ca-west-1"}

module "region_eucentral1" {
  source    = "./regional_outpost"
  providers = { aws = aws.eucentral1 }
  region    = "eu-central-1"
}


#module "region_eucentral2" {  source    = "./regional_outpost"  providers = { aws = aws.eucentral2 }  region    = "eu-central-2"}

module "region_eunorth1" {
  source    = "./regional_outpost"
  providers = { aws = aws.eunorth1 }
  region    = "eu-north-1"
}

#module "region_eusouth1" {  source    = "./regional_outpost"  providers = { aws = aws.eusouth1 }  region    = "eu-south-1"}


#module "region_eusouth2" {  source    = "./regional_outpost"  providers = { aws = aws.eusouth2 }  region    = "eu-south-2"}

module "region_euwest1" {
  source    = "./regional_outpost"
  providers = { aws = aws.euwest1 }
  region    = "eu-west-1"
}


module "region_euwest2" {
  source    = "./regional_outpost"
  providers = { aws = aws.euwest2 }
  region    = "eu-west-2"
}

module "region_euwest3" {
  source    = "./regional_outpost"
  providers = { aws = aws.euwest3 }
  region    = "eu-west-3"
}

#module "region_ilcentral1" {  source    = "./regional_outpost"  providers = { aws = aws.ilcentral1 }  region    = "il-central-1"}

#module "region_mecentral1" {  source    = "./regional_outpost"  providers = { aws = aws.mecentral1 }  region    = "me-central-1"}

#module "region_mesouth1" {  source    = "./regional_outpost"  providers = { aws = aws.mesouth1 }  region    = "me-south-1"}

#module "region_mxcentral1" {  source    = "./regional_outpost"  providers = { aws = aws.mxcentral1 }  region    = "mx-central-1"}

module "region_saeast1" {
  source    = "./regional_outpost"
  providers = { aws = aws.saeast1 }
  region    = "sa-east-1"
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


module "region_uswest2" {
  source    = "./regional_outpost"
  providers = { aws = aws.uswest2 }
  region    = "us-west-2"
}


# output "regions" {
#   value = [
#     module.region_useast2.full_html_url,
#     module.region_useast1.full_html_url,
#     module.region_uswest1.full_html_url,
#     module.region_eucentral1.full_html_url,
#     module.region_apsoutheast1.full_html_url
#   ]
# }

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
# resource "aws_cloudformation_stack" "eliza_stack" {
#   count = 0 # turn off now now
#   name          = "tine-agent"
#   capabilities  = ["CAPABILITY_NAMED_IAM"]
#   template_body = file("ec2.yml")
#   parameters = {
#     AmiId                 = module.region_uswest1.ami_id
#     GroqKey               = var.groq_key
#     TwitterPassword       = var.twitter_password
#     TwitterUserName       = var.twitter_user_name
#     TwitterEmail          = var.twitter_mail
#     LaunchTemplateVersion = var.lt_version
#     NameTag               = "tine-dev2"
#     AgentCodeName         = "tine_agent_3"
#   }
# }

locals {
  all_regions = [

    module.region_apnortheast1,
    module.region_apnortheast2,
    module.region_apnortheast3,
    module.region_apsouth1,
    module.region_apsoutheast1,
    module.region_apsoutheast2,
    module.region_cacentral1,
    module.region_eucentral1,
    module.region_eunorth1,
    module.region_euwest1,
    module.region_euwest2,
    module.region_euwest3,
    module.region_saeast1,
    module.region_useast1,
    module.region_useast2,
    module.region_uswest1,
    module.region_uswest2,

  ]
}

resource "local_file" "items_to_html" {
  content = join("\n", [
    for alias in local.all_regions :
    alias.full_html_url
  ])
  filename = "installer.md"
}


# resource "local_file" "items_to_html" {
#   content  = join("\n", [
#     module.region_useast2.full_html_url,
#     module.region_useast1.full_html_url,
#     module.region_uswest1.full_html_url,
#     module.region_eucentral1.full_html_url,
#     module.region_apsoutheast1.full_html_url
#   ])
#   filename = "installer.md"
# }

