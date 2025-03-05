
 variable patch { default = "v1" }
 module "deploy_PluginZksync" {
 source  = "../runbook"
 runbook = "PluginZksync"
 patch   = var.patch
 }
