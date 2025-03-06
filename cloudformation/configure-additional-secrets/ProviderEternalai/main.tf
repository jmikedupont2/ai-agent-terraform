
variable "patch" { default = "v1" }
module "deploy_ProviderEternalai" {
  source  = "../runbook"
  runbook = "ProviderEternalai"
  patch   = var.patch
}
