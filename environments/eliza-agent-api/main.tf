variable instance_types {}
variable "spot_max_price" {}
variable "branch" {}
variable "project" {}

variable "region" {}
variable "domain" {}
variable "aws_account_id" {}
variable "ami_id" {}
#variable "ami_name" {}

variable "tags" {}
variable "name" {}
variable "key_name" {}

locals {
  name     = var.project
  domain   = var.domain
  tags = {
    project = var.project
  }
  dev_tags = {  }
}

locals {
  ami_id     = var.ami_id
}

module "vpc" {
  source = "./components/vpc"
   name = var.project 
  aws_availability_zones = var.aws_availability_zones

}

locals {
  ec2_public_subnet_id_1 = module.vpc.ec2_public_subnet_id_1
  ec2_public_subnet_id_2 = module.vpc.ec2_public_subnet_id_2
  vpc_id                 = module.vpc.vpc_id
}

module "security" {
  source = "./components/security"
  vpc_id = local.vpc_id
  tags   = local.tags
  name   = local.name
}

module "kp" {
  source = "./components/keypairs"
}

module "roles" {
  source = "./components/roles"
  tags   = local.tags
}


output "security_group_id" {
  value = module.security.security_group_id
}

module "eliza" {
  source                     = "./eliza" # fixme rename to eliza
#  ami_name = var.ami_name
  branch =    var.branch
  git_repo = "https://github.com/meta-introspector/cloud-deployment-eliza/"
  ssm_profile_arn            = module.roles.ssm_profile_arn
  ec2_subnet_id              = module.vpc.ec2_public_subnet_id_1
  iam_instance_profile_name  = module.roles.ssm_profile_name
  key_name                   = var.key_name
  instance_types = var.instance_types
  aws_account_id             = var.aws_account_id
  region                     = var.region
  internal_security_group_id = module.security.internal_security_group_id
  tags                       = local.tags
  ami_id                     = local.ami_id
  vpc_id                     = local.vpc_id
  name = "docker-agent-ami"
}

output "vpc" {
  value = module.vpc
}
