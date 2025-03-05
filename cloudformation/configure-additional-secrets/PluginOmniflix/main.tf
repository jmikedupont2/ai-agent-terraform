
 variable patch { default = "v1" }
 module "deploy_PluginOmniflix" {
 source  = "../runbook"
 runbook = "PluginOmniflix"
 patch   = var.patch
 }
