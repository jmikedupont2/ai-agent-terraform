locals {
  patch   = "v1"
  runbook = "create-parameters"
}

module "deploy" {
  source  = "../runbook"
  runbook = local.runbook
  patch   = local.patch
}

