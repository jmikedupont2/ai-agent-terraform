
variable "patch" { default = "v1" }
module "deploy_PluginTee" {
  source  = "../runbook"
  runbook = "PluginTee"
  patch   = var.patch
}
