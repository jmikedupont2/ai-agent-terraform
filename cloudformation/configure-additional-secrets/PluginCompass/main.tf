
variable "patch" { default = "v1" }
module "deploy_PluginCompass" {
  source  = "../runbook"
  runbook = "PluginCompass"
  patch   = var.patch
}
