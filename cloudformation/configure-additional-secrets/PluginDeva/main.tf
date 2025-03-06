
variable "patch" { default = "v1" }
module "deploy_PluginDeva" {
  source  = "../runbook"
  runbook = "PluginDeva"
  patch   = var.patch
}
