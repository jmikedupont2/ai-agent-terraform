
variable "patch" { default = "v1" }
module "deploy_ClientWhatsapp" {
  source  = "../runbook"
  runbook = "ClientWhatsapp"
  patch   = var.patch
}
