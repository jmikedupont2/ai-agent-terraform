
 variable patch { default = "v1" }
 module "deploy_PluginAvalanche" {
 source  = "../runbook"
 runbook = "PluginAvalanche"
 patch   = var.patch
 }
