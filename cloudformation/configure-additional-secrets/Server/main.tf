
variable "patch" { default = "v1" }
module "deploy_Server" {
  source  = "../runbook"
  runbook = "Server"
  patch   = var.patch
}
