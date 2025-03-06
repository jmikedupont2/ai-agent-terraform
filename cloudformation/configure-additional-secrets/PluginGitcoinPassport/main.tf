
variable "patch" { default = "v1" }
module "deploy_PluginGitcoinPassport" {
  source  = "../runbook"
  runbook = "PluginGitcoinPassport"
  patch   = var.patch
}
