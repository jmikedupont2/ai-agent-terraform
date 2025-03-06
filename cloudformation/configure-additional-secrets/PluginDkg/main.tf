
variable "patch" { default = "v1" }
module "deploy_PluginDkg" {
  source  = "../runbook"
  runbook = "PluginDkg"
  patch   = var.patch
}
