
 variable patch { default = "v1" }
 module "deploy_PluginIq6900" {
 source  = "../runbook"
 runbook = "PluginIq6900"
 patch   = var.patch
 }
