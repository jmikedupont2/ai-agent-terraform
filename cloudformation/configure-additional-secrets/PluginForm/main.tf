
variable "patch" { default = "v1" }
module "deploy_PluginForm" {
  source  = "../runbook"
  runbook = "PluginForm"
  patch   = var.patch
}
