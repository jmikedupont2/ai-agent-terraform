
 variable patch { default = "v1" }
 module "deploy_ProviderOllama" {
 source  = "../runbook"
 runbook = "ProviderOllama"
 patch   = var.patch
 }
