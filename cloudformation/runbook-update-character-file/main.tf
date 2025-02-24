locals {
  patch   = "v1"
  runbook = "update-character"
}

module "deploy" {
  source  = "../runbook"
  runbook = local.runbook
  patch   = local.patch
}

