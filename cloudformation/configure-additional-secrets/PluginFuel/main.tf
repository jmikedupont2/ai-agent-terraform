
variable "patch" { default = "v1" }
module "deploy_PluginFuel" {
  source  = "../runbook"
  runbook = "PluginFuel"
  patch   = var.patch
}
