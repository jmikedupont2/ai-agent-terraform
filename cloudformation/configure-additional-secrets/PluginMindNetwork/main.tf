
variable "patch" { default = "v1" }
module "deploy_PluginMindNetwork" {
  source  = "../runbook"
  runbook = "PluginMindNetwork"
  patch   = var.patch
}
