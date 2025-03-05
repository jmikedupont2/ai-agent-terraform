
 variable patch { default = "v1" }
 module "deploy_PluginCosmos" {
 source  = "../runbook"
 runbook = "PluginCosmos"
 patch   = var.patch
 }
