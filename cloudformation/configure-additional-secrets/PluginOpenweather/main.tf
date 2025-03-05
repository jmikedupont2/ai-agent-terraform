
 variable patch { default = "v1" }
 module "deploy_PluginOpenweather" {
 source  = "../runbook"
 runbook = "PluginOpenweather"
 patch   = var.patch
 }
