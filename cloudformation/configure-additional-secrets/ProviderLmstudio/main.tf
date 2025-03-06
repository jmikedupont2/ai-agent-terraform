
variable "patch" { default = "v1" }
module "deploy_ProviderLmstudio" {
  source  = "../runbook"
  runbook = "ProviderLmstudio"
  patch   = var.patch
}
