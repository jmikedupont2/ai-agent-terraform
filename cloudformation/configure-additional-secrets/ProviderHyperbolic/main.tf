
variable "patch" { default = "v1" }
module "deploy_ProviderHyperbolic" {
  source  = "../runbook"
  runbook = "ProviderHyperbolic"
  patch   = var.patch
}
