
 variable patch { default = "v1" }
 module "deploy_PluginPythData" {
 source  = "../runbook"
 runbook = "PluginPythData"
 patch   = var.patch
 }
