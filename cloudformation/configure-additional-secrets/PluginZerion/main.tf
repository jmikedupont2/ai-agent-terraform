
 variable patch { default = "v1" }
 module "deploy_PluginZerion" {
 source  = "../runbook"
 runbook = "PluginZerion"
 patch   = var.patch
 }
