
 variable patch { default = "v1" }
 module "deploy_ProviderSecretAi" {
 source  = "../runbook"
 runbook = "ProviderSecretAi"
 patch   = var.patch
 }
