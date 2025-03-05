
 variable patch { default = "v1" }
 module "deploy_ProviderNearai" {
 source  = "../runbook"
 runbook = "ProviderNearai"
 patch   = var.patch
 }
