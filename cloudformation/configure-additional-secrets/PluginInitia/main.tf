
 variable patch { default = "v1" }
 module "deploy_PluginInitia" {
 source  = "../runbook"
 runbook = "PluginInitia"
 patch   = var.patch
 }
