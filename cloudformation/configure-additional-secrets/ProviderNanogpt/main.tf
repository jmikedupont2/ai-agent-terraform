
 variable patch { default = "v1" }
 module "deploy_ProviderNanogpt" {
 source  = "../runbook"
 runbook = "ProviderNanogpt"
 patch   = var.patch
 }
