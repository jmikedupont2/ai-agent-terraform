
variable "patch" { default = "v1" }
module "deploy_PluginCoinbaseCharity" {
  source  = "../runbook"
  runbook = "PluginCoinbaseCharity"
  patch   = var.patch
}
