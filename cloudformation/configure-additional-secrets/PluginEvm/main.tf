
variable "patch" { default = "v1" }
module "deploy_PluginEvm" {
  source  = "../runbook"
  runbook = "PluginEvm"
  patch   = var.patch
}
