
variable "patch" { default = "v1" }
module "deploy_ClientTwitter" {
  source  = "../runbook"
  runbook = "ClientTwitter"
  patch   = var.patch
}
