
variable "patch" { default = "v1" }
module "deploy_PluginGiphy" {
  source  = "../runbook"
  runbook = "PluginGiphy"
  patch   = var.patch
}
