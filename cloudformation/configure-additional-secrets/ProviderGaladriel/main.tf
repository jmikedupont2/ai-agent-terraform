
 variable patch { default = "v1" }
 module "deploy_ProviderGaladriel" {
 source  = "../runbook"
 runbook = "ProviderGaladriel"
 patch   = var.patch
 }
