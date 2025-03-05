
 variable patch { default = "v1" }
 module "deploy_PluginBtcfun" {
 source  = "../runbook"
 runbook = "PluginBtcfun"
 patch   = var.patch
 }
