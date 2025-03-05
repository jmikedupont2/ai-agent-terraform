
 variable patch { default = "v1" }
 module "deploy_PluginCronoszkevm" {
 source  = "../runbook"
 runbook = "PluginCronoszkevm"
 patch   = var.patch
 }
