
variable "patch" { default = "v1" }
module "deploy_PluginQuickIntel" {
  source  = "../runbook"
  runbook = "PluginQuickIntel"
  patch   = var.patch
}
