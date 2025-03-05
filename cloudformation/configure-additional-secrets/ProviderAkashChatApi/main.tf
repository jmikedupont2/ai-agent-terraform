
 variable patch { default = "v1" }
 module "deploy_ProviderAkashChatApi" {
 source  = "../runbook"
 runbook = "ProviderAkashChatApi"
 patch   = var.patch
 }
