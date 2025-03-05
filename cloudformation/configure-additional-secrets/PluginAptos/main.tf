
 variable patch { default = "v1" }
 module "deploy_PluginAptos" {
 source  = "../runbook"
 runbook = "PluginAptos"
 patch   = var.patch
 }
