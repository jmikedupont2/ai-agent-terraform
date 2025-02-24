locals {
  patch   = "v1"
  runbook = "docker-status"
}

module "deploy" {
  source  = "../runbook"
  runbook = local.runbook
  patch   = local.patch
}

