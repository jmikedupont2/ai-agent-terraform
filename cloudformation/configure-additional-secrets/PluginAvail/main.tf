
variable "patch" { default = "v1" }
module "deploy_PluginAvail" {
  source  = "../runbook"
  runbook = "PluginAvail"
  patch   = var.patch
}
