
variable "patch" { default = "v1" }
module "deploy_PluginMina" {
  source  = "../runbook"
  runbook = "PluginMina"
  patch   = var.patch
}
