
variable "patch" { default = "v1" }
module "deploy_ProviderLivepeer" {
  source  = "../runbook"
  runbook = "ProviderLivepeer"
  patch   = var.patch
}
