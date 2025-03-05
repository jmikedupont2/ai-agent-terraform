
 variable patch { default = "v1" }
 module "deploy_PluginEmail" {
 source  = "../runbook"
 runbook = "PluginEmail"
 patch   = var.patch
 }
