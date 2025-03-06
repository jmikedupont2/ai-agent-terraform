
variable "patch" { default = "v1" }
module "deploy_PluginAkash" {
  source  = "../runbook"
  runbook = "PluginAkash"
  patch   = var.patch
}
