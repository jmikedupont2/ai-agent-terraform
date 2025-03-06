
variable "patch" { default = "v1" }
module "deploy_ProviderVenice" {
  source  = "../runbook"
  runbook = "ProviderVenice"
  patch   = var.patch
}
