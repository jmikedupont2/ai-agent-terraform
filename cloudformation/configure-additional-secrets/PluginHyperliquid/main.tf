
variable "patch" { default = "v1" }
module "deploy_PluginHyperliquid" {
  source  = "../runbook"
  runbook = "PluginHyperliquid"
  patch   = var.patch
}
