
 variable patch { default = "v1" }
 module "deploy_ProviderDeepseek" {
 source  = "../runbook"
 runbook = "ProviderDeepseek"
 patch   = var.patch
 }
