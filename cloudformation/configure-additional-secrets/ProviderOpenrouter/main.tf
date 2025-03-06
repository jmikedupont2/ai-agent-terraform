
variable "patch" { default = "v1" }
module "deploy_ProviderOpenrouter" {
  source  = "../runbook"
  runbook = "ProviderOpenrouter"
  patch   = var.patch
}
