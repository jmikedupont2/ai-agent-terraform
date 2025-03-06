
variable "patch" { default = "v1" }
module "deploy_AdapterPglite" {
  source  = "../runbook"
  runbook = "AdapterPglite"
  patch   = var.patch
}
