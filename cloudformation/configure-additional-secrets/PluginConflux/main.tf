
variable "patch" { default = "v1" }
module "deploy_PluginConflux" {
  source  = "../runbook"
  runbook = "PluginConflux"
  patch   = var.patch
}
