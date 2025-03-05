
 variable patch { default = "v1" }
 module "deploy_PluginBirdeye" {
 source  = "../runbook"
 runbook = "PluginBirdeye"
 patch   = var.patch
 }
