
variable "patch" { default = "v1" }
module "deploy_PluginQuai" {
  source  = "../runbook"
  runbook = "PluginQuai"
  patch   = var.patch
}
