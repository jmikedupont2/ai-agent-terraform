
 variable patch { default = "v1" }
 module "deploy_ProviderOpenai" {
 source  = "../runbook"
 runbook = "ProviderOpenai"
 patch   = var.patch
 }
