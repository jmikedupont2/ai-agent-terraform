variable "regions" {}

# dynamic "provider" "aws" {
#   for_each = local.providers
#   content {
#     alias  = provider.value.alias
#     region = provider.value.region
#   }
# }

#output "debug" {
#for region in var.regions : 
#  value = var.regions.names

#}

locals {
  region_providers = {
    for region in var.regions :
    replace(region, "-", "") => {
      alias  = replace(region, "-", "")
      region = region
    }
  }
}

output "provider_configs" {
  value = {
    for alias, config in local.region_providers :
    alias => "provider \"aws\" {\n  alias  = \"${config.alias}\"\n  region = \"${config.region}\"\n}"
  }
}

locals {
  module_configs = {
    for alias, config in local.region_providers :
    alias => "module \"region_${alias}\" {\n  source    = \"./regional_outpost\"\n  providers = { aws = aws.${alias} }\n  region    = \"${config.region}\"\n}"
  }
}

output "module_configs" {
  value = local.module_configs
}

#  module "region_apsoutheast1" {
#   source    = "./regional_outpost"
#   providers = { aws = aws.apsoutheast1 }
#   region    = "ap-southeast-1"
# }

