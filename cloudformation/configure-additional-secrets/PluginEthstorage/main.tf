
 variable patch { default = "v1" }
 module "deploy_PluginEthstorage" {
 source  = "../runbook"
 runbook = "PluginEthstorage"
 patch   = var.patch
 }
