
variable "patch" { default = "v1" }
module "deploy_PluginArthera" {
  source  = "../runbook"
  runbook = "PluginArthera"
  patch   = var.patch
}
