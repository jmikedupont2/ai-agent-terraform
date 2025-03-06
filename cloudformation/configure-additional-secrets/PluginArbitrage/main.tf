
variable "patch" { default = "v1" }
module "deploy_PluginArbitrage" {
  source  = "../runbook"
  runbook = "PluginArbitrage"
  patch   = var.patch
}
