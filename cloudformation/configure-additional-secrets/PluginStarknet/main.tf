
 variable patch { default = "v1" }
 module "deploy_PluginStarknet" {
 source  = "../runbook"
 runbook = "PluginStarknet"
 patch   = var.patch
 }
