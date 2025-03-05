
 variable patch { default = "v1" }
 module "deploy_PluginThirdweb" {
 source  = "../runbook"
 runbook = "PluginThirdweb"
 patch   = var.patch
 }
