
 variable patch { default = "v1" }
 module "deploy_ProviderGaianet" {
 source  = "../runbook"
 runbook = "ProviderGaianet"
 patch   = var.patch
 }
