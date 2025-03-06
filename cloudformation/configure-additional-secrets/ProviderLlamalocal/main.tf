
variable "patch" { default = "v1" }
module "deploy_ProviderLlamalocal" {
  source  = "../runbook"
  runbook = "ProviderLlamalocal"
  patch   = var.patch
}
