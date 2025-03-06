
variable "patch" { default = "v1" }
module "deploy_PluginLit" {
  source  = "../runbook"
  runbook = "PluginLit"
  patch   = var.patch
}
