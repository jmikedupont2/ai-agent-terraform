variable "runbook" {}
variable "patch" {}
locals {
  patch   = var.patch
  runbook = var.runbook
}

# if anyone has an idea how to refactor this....
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

# now deploy

module "region_apnortheast1" {
  source    = "./region"
  providers = { aws = aws.apnortheast1 }
  region    = "ap-northeast-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_apnortheast2" {
  source    = "./region"
  providers = { aws = aws.apnortheast2 }
  region    = "ap-northeast-2"
  runbook   = local.runbook

  patch = local.patch
}

module "region_apnortheast3" {
  source    = "./region"
  providers = { aws = aws.apnortheast3 }
  region    = "ap-northeast-3"
  runbook   = local.runbook

  patch = local.patch
}

module "region_apsouth1" {
  source    = "./region"
  providers = { aws = aws.apsouth1 }
  region    = "ap-south-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_apsoutheast1" {
  source    = "./region"
  providers = { aws = aws.apsoutheast1 }
  region    = "ap-southeast-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_apsoutheast2" {
  source    = "./region"
  providers = { aws = aws.apsoutheast2 }
  region    = "ap-southeast-2"
  runbook   = local.runbook

  patch = local.patch
}

module "region_cacentral1" {
  source    = "./region"
  providers = { aws = aws.cacentral1 }
  region    = "ca-central-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_eucentral1" {
  source    = "./region"
  providers = { aws = aws.eucentral1 }
  region    = "eu-central-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_eunorth1" {
  source    = "./region"
  providers = { aws = aws.eunorth1 }
  region    = "eu-north-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_euwest1" {
  source    = "./region"
  providers = { aws = aws.euwest1 }
  region    = "eu-west-1"
  runbook   = local.runbook

  patch = local.patch
}


module "region_euwest2" {
  source    = "./region"
  providers = { aws = aws.euwest2 }
  region    = "eu-west-2"
  runbook   = local.runbook

  patch = local.patch
}

module "region_euwest3" {
  source    = "./region"
  providers = { aws = aws.euwest3 }
  region    = "eu-west-3"
  runbook   = local.runbook

  patch = local.patch
}

module "region_saeast1" {
  source    = "./region"
  providers = { aws = aws.saeast1 }
  region    = "sa-east-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_useast1" {
  source    = "./region"
  providers = { aws = aws.useast1 }
  region    = "us-east-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_useast2" {
  source    = "./region"
  providers = { aws = aws.useast2 }
  region    = "us-east-2"
  runbook   = local.runbook

  patch = local.patch
}

module "region_uswest1" {
  source    = "./region"
  providers = { aws = aws.uswest1 }
  region    = "us-west-1"
  runbook   = local.runbook

  patch = local.patch
}

module "region_uswest2" {
  source    = "./region"
  providers = { aws = aws.uswest2 }
  region    = "us-west-2"
  patch     = local.patch
  runbook   = local.runbook

}

#module "region_apsouth2" { source    = "../regional_outpost_reuse" providers = { aws = aws.apsouth2 } region    = "ap-south-2"}
#module "region_apsoutheast3" { source    = "../regional_outpost_reuse" providers = { aws = aws.apsoutheast3 } region    = "ap-southeast-3"}
#module "region_apsoutheast4" { source    = "../regional_outpost_reuse" providers = { aws = aws.apsoutheast4 } region    = "ap-southeast-4"}
#module "region_apsoutheast5" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.apsoutheast5 }  region    = "ap-southeast-5"}
#module "region_apsoutheast7" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.apsoutheast7 }  region    = "ap-southeast-7"}
#module "region_cawest1" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.cawest1 }  region    = "ca-west-1"}
#module "region_eucentral2" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.eucentral2 }  region    = "eu-central-2"}
#module "region_eusouth1" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.eusouth1 }  region    = "eu-south-1"}
#module "region_eusouth2" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.eusouth2 }  region    = "eu-south-2"}
#module "region_ilcentral1" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.ilcentral1 }  region    = "il-central-1"}
#module "region_mecentral1" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.mecentral1 }  region    = "me-central-1"}
#module "region_mesouth1" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.mesouth1 }  region    = "me-south-1"}
#module "region_mxcentral1" {  source    = "../regional_outpost_reuse"  providers = { aws = aws.mxcentral1 }  region    = "mx-central-1"}

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
  filename = "diagnose_docker.md"
}

