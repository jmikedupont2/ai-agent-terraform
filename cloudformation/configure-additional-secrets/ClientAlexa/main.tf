
variable "patch" { default = "v1" }
module "deploy_ClientAlexa" {
  source  = "../runbook"
  runbook = "ClientAlexa"
  patch   = var.patch
}
