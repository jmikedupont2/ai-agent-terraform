
 variable patch { default = "v1" }
 module "deploy_PluginAutonome" {
 source  = "../runbook"
 runbook = "PluginAutonome"
 patch   = var.patch
 }
