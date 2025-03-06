
variable "patch" { default = "v1" }
module "deploy_PluginImgflip" {
  source  = "../runbook"
  runbook = "PluginImgflip"
  patch   = var.patch
}
