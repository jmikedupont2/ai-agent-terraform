
variable "patch" { default = "v1" }
module "deploy_PluginStargaze" {
  source  = "../runbook"
  runbook = "PluginStargaze"
  patch   = var.patch
}
