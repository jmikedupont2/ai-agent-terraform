
variable "patch" { default = "v1" }
module "deploy_PluginRouterNitro" {
  source  = "../runbook"
  runbook = "PluginRouterNitro"
  patch   = var.patch
}
