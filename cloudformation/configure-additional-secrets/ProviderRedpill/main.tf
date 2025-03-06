
variable "patch" { default = "v1" }
module "deploy_ProviderRedpill" {
  source  = "../runbook"
  runbook = "ProviderRedpill"
  patch   = var.patch
}
