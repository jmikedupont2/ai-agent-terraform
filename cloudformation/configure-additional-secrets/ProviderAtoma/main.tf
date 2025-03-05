
 variable patch { default = "v1" }
 module "deploy_ProviderAtoma" {
 source  = "../runbook"
 runbook = "ProviderAtoma"
 patch   = var.patch
 }
