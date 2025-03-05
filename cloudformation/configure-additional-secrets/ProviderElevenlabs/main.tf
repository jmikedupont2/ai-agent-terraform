
 variable patch { default = "v1" }
 module "deploy_ProviderElevenlabs" {
 source  = "../runbook"
 runbook = "ProviderElevenlabs"
 patch   = var.patch
 }
