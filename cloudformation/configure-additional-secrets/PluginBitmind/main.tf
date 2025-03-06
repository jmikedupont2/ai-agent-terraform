
variable "patch" { default = "v1" }
module "deploy_PluginBitmind" {
  source  = "../runbook"
  runbook = "PluginBitmind"
  patch   = var.patch
}
