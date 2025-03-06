
variable "patch" { default = "v1" }
module "deploy_PluginGenlayer" {
  source  = "../runbook"
  runbook = "PluginGenlayer"
  patch   = var.patch
}
