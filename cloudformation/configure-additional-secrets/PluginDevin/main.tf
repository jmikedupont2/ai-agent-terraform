
variable "patch" { default = "v1" }
module "deploy_PluginDevin" {
  source  = "../runbook"
  runbook = "PluginDevin"
  patch   = var.patch
}
