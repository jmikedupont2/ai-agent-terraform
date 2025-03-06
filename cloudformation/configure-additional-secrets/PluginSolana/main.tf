
variable "patch" { default = "v1" }
module "deploy_PluginSolana" {
  source  = "../runbook"
  runbook = "PluginSolana"
  patch   = var.patch
}
