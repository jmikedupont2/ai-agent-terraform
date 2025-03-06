
variable "patch" { default = "v1" }
module "deploy_ClientFarcaster" {
  source  = "../runbook"
  runbook = "ClientFarcaster"
  patch   = var.patch
}
