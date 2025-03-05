
 variable patch { default = "v1" }
 module "deploy_ProviderNineteenAi" {
 source  = "../runbook"
 runbook = "ProviderNineteenAi"
 patch   = var.patch
 }
