
variable "patch" { default = "v1" }
module "deploy_ProviderInfera" {
  source  = "../runbook"
  runbook = "ProviderInfera"
  patch   = var.patch
}
