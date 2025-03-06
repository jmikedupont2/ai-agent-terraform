
variable "patch" { default = "v1" }
module "deploy_PluginDcap" {
  source  = "../runbook"
  runbook = "PluginDcap"
  patch   = var.patch
}
