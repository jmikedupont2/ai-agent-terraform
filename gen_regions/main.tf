

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
  #for_each = data.aws_regions.all
  source = "../cloudformation/genprovider"
  regions = data.aws_regions.all.names
}

output "gen_regions" {
  value = module.genprovider
}

