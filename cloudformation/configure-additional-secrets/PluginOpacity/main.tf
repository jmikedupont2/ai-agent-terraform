
variable "patch" { default = "v1" }
module "deploy_PluginOpacity" {
  source  = "../runbook"
  runbook = "PluginOpacity"
  patch   = var.patch
}
