
variable "patch" { default = "v1" }
module "deploy_PluginNews" {
  source  = "../runbook"
  runbook = "PluginNews"
  patch   = var.patch
}
