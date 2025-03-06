
variable "patch" { default = "v1" }
module "deploy_PluginNear" {
  source  = "../runbook"
  runbook = "PluginNear"
  patch   = var.patch
}
