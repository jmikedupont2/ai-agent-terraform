
 variable patch { default = "v1" }
 module "deploy_ProviderGroq" {
 source  = "../runbook"
 runbook = "ProviderGroq"
 patch   = var.patch
 }
