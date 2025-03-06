locals {
  patch = "v1"
}
module "deploy_Server" {
  source  = "../runbook"
  runbook = "Server"
  patch   = local.patch
}

module "deploy_ClientDiscord" {
  source  = "../runbook"
  runbook = "ClientDiscord"
  patch   = local.patch
}
# module "deploy_ClientFarcaster" {
#           source  = "../runbook"
#           runbook = "ClientFarcaster"
#           patch   = local.patch
#         }
# module "deploy_ClientTelegram" {
#           source  = "../runbook"
#           runbook = "ClientTelegram"
#           patch   = local.patch
#         }
# module "deploy_ClientTwitter" {
#           source  = "../runbook"
#           runbook = "ClientTwitter"
#           patch   = local.patch
#         }
# module "deploy_ProviderOpenai" {
#           source  = "../runbook"
#           runbook = "ProviderOpenai"
#           patch   = local.patch
#         }

