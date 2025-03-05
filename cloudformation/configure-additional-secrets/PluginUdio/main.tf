
 variable patch { default = "v1" }
 module "deploy_PluginUdio" {
 source  = "../runbook"
 runbook = "PluginUdio"
 patch   = var.patch
 }
