
variable "patch" { default = "v1" }
module "deploy_ClientTelegram" {
  source  = "../runbook"
  runbook = "ClientTelegram"
  patch   = var.patch
}
