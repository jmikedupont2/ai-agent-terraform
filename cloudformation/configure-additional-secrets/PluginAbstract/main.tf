
 variable patch { default = "v1" }
 module "deploy_PluginAbstract" {
 source  = "../runbook"
 runbook = "PluginAbstract"
 patch   = var.patch
 }
