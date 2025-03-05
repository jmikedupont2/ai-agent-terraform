
 variable patch { default = "v1" }
 module "deploy_ProviderFalai" {
 source  = "../runbook"
 runbook = "ProviderFalai"
 patch   = var.patch
 }
