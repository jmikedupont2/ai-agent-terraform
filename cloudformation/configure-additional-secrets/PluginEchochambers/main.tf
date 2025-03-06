
variable "patch" { default = "v1" }
module "deploy_PluginEchochambers" {
  source  = "../runbook"
  runbook = "PluginEchochambers"
  patch   = var.patch
}
