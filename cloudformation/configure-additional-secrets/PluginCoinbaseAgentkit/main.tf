
 variable patch { default = "v1" }
 module "deploy_PluginCoinbaseAgentkit" {
 source  = "../runbook"
 runbook = "PluginCoinbaseAgentkit"
 patch   = var.patch
 }
