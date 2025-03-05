
 variable patch { default = "v1" }
 module "deploy_PluginSei" {
 source  = "../runbook"
 runbook = "PluginSei"
 patch   = var.patch
 }
