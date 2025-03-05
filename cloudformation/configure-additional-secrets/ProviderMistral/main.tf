
 variable patch { default = "v1" }
 module "deploy_ProviderMistral" {
 source  = "../runbook"
 runbook = "ProviderMistral"
 patch   = var.patch
 }
