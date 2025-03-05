
 variable patch { default = "v1" }
 module "deploy_ProviderAliBailian" {
 source  = "../runbook"
 runbook = "ProviderAliBailian"
 patch   = var.patch
 }
