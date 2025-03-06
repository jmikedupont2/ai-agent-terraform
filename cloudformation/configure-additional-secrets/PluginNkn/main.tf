
variable "patch" { default = "v1" }
module "deploy_PluginNkn" {
  source  = "../runbook"
  runbook = "PluginNkn"
  patch   = var.patch
}
