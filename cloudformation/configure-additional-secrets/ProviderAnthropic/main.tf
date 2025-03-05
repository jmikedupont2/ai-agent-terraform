
 variable patch { default = "v1" }
 module "deploy_ProviderAnthropic" {
 source  = "../runbook"
 runbook = "ProviderAnthropic"
 patch   = var.patch
 }
