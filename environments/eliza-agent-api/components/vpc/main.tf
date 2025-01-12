#from  https://github.com/terraform-aws-modules/terraform-aws-vpc

data "aws_availability_zones" "available" {}
variable name {}
variable aws_availability_zones {}
locals {
  name = var.name
  vpc_cidr = "10.0.0.0/16"
  
  #azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  azs      = var.aws_availability_zones

  tags = {
    project = local.name
    #    GithubRepo = "terraform-aws-vpc"
    #    GithubOrg  = "terraform-aws-modules"
  }
}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  name            = local.name
  cidr            = local.vpc_cidr
  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  #   database_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]
  #   elasticache_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 12)]
  #   redshift_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 16)]
  #   intra_subnets       = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 20)]
  private_subnet_names = ["Private Subnet One", "Private Subnet Two"]
  #   # public_subnet_names omitted to show default name generation for all three subnets
  #   database_subnet_names    = ["DB Subnet One"]
  #   elasticache_subnet_names = ["Elasticache Subnet One", "Elasticache Subnet Two"]
  #   redshift_subnet_names    = ["Redshift Subnet One", "Redshift Subnet Two", "Redshift Subnet Three"]
  #   intra_subnet_names       = []
  #   create_database_subnet_group  = false
  #   manage_default_network_acl    = false
  #   manage_default_route_table    = false
  #   manage_default_security_group = false
  #   enable_dns_hostnames = true
  #   enable_dns_support   = true
  enable_nat_gateway = false
  #   single_nat_gateway = false
  #   customer_gateways = {
  #     IP1 = {
  #       bgp_asn     = 65112
  #       ip_address  = "1.2.3.4"
  #       device_name = "some_name"
  #     },
  #     IP2 = {
  #       bgp_asn    = 65112
  #       ip_address = "5.6.7.8"
  #     }
  #   }
  #   enable_vpn_gateway = true
  #   enable_dhcp_options              = true
  #   dhcp_options_domain_name         = "service.consul"
  #   dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  #   # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  #   vpc_flow_log_iam_role_name            = "vpc-complete-example-role"
  #   vpc_flow_log_iam_role_use_name_prefix = false
  #   enable_flow_log                       = true
  #   create_flow_log_cloudwatch_log_group  = true
  #   create_flow_log_cloudwatch_iam_role   = true
  #   flow_log_max_aggregation_interval     = 60

  tags = local.tags
}

output "vpc" {
  value = module.vpc
}

output "azs" {
  value      = data.aws_availability_zones.available.names
}
