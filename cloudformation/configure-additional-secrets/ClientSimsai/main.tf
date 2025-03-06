
variable "patch" { default = "v1" }
module "deploy_ClientSimsai" {
  source  = "../runbook"
  runbook = "ClientSimsai"
  patch   = var.patch
}
