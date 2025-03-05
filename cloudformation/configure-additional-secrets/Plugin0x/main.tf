
 variable patch { default = "v1" }
 module "deploy_Plugin0x" {
 source  = "../runbook"
 runbook = "Plugin0x"
 patch   = var.patch
 }
