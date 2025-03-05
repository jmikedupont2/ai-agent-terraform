
 variable patch { default = "v1" }
 module "deploy_PluginBnb" {
 source  = "../runbook"
 runbook = "PluginBnb"
 patch   = var.patch
 }
