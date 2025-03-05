
 variable patch { default = "v1" }
 module "deploy_PluginInjective" {
 source  = "../runbook"
 runbook = "PluginInjective"
 patch   = var.patch
 }
