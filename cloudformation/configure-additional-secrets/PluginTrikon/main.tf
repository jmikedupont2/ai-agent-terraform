
 variable patch { default = "v1" }
 module "deploy_PluginTrikon" {
 source  = "../runbook"
 runbook = "PluginTrikon"
 patch   = var.patch
 }
