
variable "patch" { default = "v1" }
module "deploy_PluginDATA" {
  source  = "../runbook"
  runbook = "PluginDATA"
  patch   = var.patch
}
