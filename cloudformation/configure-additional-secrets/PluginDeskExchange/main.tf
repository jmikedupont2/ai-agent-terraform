
variable "patch" { default = "v1" }
module "deploy_PluginDeskExchange" {
  source  = "../runbook"
  runbook = "PluginDeskExchange"
  patch   = var.patch
}
