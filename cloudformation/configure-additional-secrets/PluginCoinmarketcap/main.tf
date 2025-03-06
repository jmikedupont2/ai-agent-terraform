
variable "patch" { default = "v1" }
module "deploy_PluginCoinmarketcap" {
  source  = "../runbook"
  runbook = "PluginCoinmarketcap"
  patch   = var.patch
}
