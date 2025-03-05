
 variable patch { default = "v1" }
 module "deploy_Plugin0g" {
 source  = "../runbook"
 runbook = "Plugin0g"
 patch   = var.patch
 }
