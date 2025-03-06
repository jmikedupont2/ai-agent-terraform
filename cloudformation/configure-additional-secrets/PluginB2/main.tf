
variable "patch" { default = "v1" }
module "deploy_PluginB2" {
  source  = "../runbook"
  runbook = "PluginB2"
  patch   = var.patch
}
