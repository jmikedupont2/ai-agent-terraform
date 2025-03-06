
variable "patch" { default = "v1" }
module "deploy_PluginCoingecko" {
  source  = "../runbook"
  runbook = "PluginCoingecko"
  patch   = var.patch
}
