
variable "patch" { default = "v1" }
module "deploy_PluginIntiface" {
  source  = "../runbook"
  runbook = "PluginIntiface"
  patch   = var.patch
}
