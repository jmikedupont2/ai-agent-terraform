
variable "patch" { default = "v1" }
module "deploy_PluginIcp" {
  source  = "../runbook"
  runbook = "PluginIcp"
  patch   = var.patch
}
