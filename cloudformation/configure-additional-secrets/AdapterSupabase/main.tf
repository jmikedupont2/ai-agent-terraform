
 variable patch { default = "v1" }
 module "deploy_AdapterSupabase" {
 source  = "../runbook"
 runbook = "AdapterSupabase"
 patch   = var.patch
 }
