
variable "patch" { default = "v1" }
module "deploy_PluginLens" {
  source  = "../runbook"
  runbook = "PluginLens"
  patch   = var.patch
}
