
 variable patch { default = "v1" }
 module "deploy_PluginWebSearch" {
 source  = "../runbook"
 runbook = "PluginWebSearch"
 patch   = var.patch
 }
