
variable "patch" { default = "v1" }
module "deploy_ClientDiscord" {
  source  = "../runbook"
  runbook = "ClientDiscord"
  patch   = var.patch
}
