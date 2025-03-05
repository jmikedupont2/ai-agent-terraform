
 variable patch { default = "v1" }
 module "deploy_PluginEmailAutomation" {
 source  = "../runbook"
 runbook = "PluginEmailAutomation"
 patch   = var.patch
 }
