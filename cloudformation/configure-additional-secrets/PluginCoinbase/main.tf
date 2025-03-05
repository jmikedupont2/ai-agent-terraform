
 variable patch { default = "v1" }
 module "deploy_PluginCoinbase" {
 source  = "../runbook"
 runbook = "PluginCoinbase"
 patch   = var.patch
 }
