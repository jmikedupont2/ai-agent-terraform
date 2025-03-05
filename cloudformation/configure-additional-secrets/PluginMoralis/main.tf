
 variable patch { default = "v1" }
 module "deploy_PluginMoralis" {
 source  = "../runbook"
 runbook = "PluginMoralis"
 patch   = var.patch
 }
