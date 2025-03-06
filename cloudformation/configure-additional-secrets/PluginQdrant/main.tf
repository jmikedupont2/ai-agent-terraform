
variable "patch" { default = "v1" }
module "deploy_PluginQdrant" {
  source  = "../runbook"
  runbook = "PluginQdrant"
  patch   = var.patch
}
