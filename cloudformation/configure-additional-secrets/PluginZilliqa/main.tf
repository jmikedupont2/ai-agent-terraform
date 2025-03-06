
variable "patch" { default = "v1" }
module "deploy_PluginZilliqa" {
  source  = "../runbook"
  runbook = "PluginZilliqa"
  patch   = var.patch
}
