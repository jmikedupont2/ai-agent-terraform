
 variable patch { default = "v1" }
 module "deploy_PluginNvidiaNim" {
 source  = "../runbook"
 runbook = "PluginNvidiaNim"
 patch   = var.patch
 }
