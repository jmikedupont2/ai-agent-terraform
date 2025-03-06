
variable "patch" { default = "v1" }
module "deploy_PluginAllora" {
  source  = "../runbook"
  runbook = "PluginAllora"
  patch   = var.patch
}
