
variable "patch" { default = "v1" }
module "deploy_AdapterMongodb" {
  source  = "../runbook"
  runbook = "AdapterMongodb"
  patch   = var.patch
}
