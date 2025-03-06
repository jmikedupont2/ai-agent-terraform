
variable "patch" { default = "v1" }
module "deploy_PluginTon" {
  source  = "../runbook"
  runbook = "PluginTon"
  patch   = var.patch
}
