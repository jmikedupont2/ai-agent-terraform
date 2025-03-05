
 variable patch { default = "v1" }
 module "deploy_PluginStory" {
 source  = "../runbook"
 runbook = "PluginStory"
 patch   = var.patch
 }
