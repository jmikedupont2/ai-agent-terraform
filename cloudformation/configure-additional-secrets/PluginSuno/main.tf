
 variable patch { default = "v1" }
 module "deploy_PluginSuno" {
 source  = "../runbook"
 runbook = "PluginSuno"
 patch   = var.patch
 }
