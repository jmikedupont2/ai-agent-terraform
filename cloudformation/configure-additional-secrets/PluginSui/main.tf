
variable "patch" { default = "v1" }
module "deploy_PluginSui" {
  source  = "../runbook"
  runbook = "PluginSui"
  patch   = var.patch
}
