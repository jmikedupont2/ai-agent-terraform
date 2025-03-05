
 variable patch { default = "v1" }
 module "deploy_ProviderLetzai" {
 source  = "../runbook"
 runbook = "ProviderLetzai"
 patch   = var.patch
 }
