variable runbook {}
variable patch {}
module "runbook" {
  source  = "../../runbook"
  runbook = var.runbook
  patch   = var.patch
}
