
 variable patch { default = "v1" }
 module "deploy_PluginFootball" {
 source  = "../runbook"
 runbook = "PluginFootball"
 patch   = var.patch
 }
