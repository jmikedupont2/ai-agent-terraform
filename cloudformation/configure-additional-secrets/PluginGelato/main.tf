
 variable patch { default = "v1" }
 module "deploy_PluginGelato" {
 source  = "../runbook"
 runbook = "PluginGelato"
 patch   = var.patch
 }
