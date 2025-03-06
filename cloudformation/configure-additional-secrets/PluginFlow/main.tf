
variable "patch" { default = "v1" }
module "deploy_PluginFlow" {
  source  = "../runbook"
  runbook = "PluginFlow"
  patch   = var.patch
}
