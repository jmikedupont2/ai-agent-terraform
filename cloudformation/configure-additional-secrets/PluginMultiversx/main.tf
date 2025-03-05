
 variable patch { default = "v1" }
 module "deploy_PluginMultiversx" {
 source  = "../runbook"
 runbook = "PluginMultiversx"
 patch   = var.patch
 }
