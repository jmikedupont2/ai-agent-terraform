
 variable patch { default = "v1" }
 module "deploy_PluginDeepgram" {
 source  = "../runbook"
 runbook = "PluginDeepgram"
 patch   = var.patch
 }
