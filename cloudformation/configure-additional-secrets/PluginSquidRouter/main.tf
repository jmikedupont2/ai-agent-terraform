
variable "patch" { default = "v1" }
module "deploy_PluginSquidRouter" {
  source  = "../runbook"
  runbook = "PluginSquidRouter"
  patch   = var.patch
}
