variable "spot_max_price" {
  default = 0.028
}
variable "region" {}
variable "key_name" {
  default = "mdupont-deployer-key" # FIXME: move to settings
}
locals {
  #  instance_type = "t3.large"
  #  instance_type = "t3.medium"
  ami_name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
  name     = "eliza"
  domain   = var.domain
  tags = {
    project = "eliza"
  }
  dev_tags = {
    sandbox = "kye"
  }
}
variable "domain" {}
variable "aws_account_id" {}
variable "ami_id" {}
variable "tags" {}
variable "name" {}


locals {
  ami_id     = var.ami_id
#  new_ami_id = "ami-08093b6770af41b14" # environments/eliza-aws-agent-api/dev/us-east-1/components/machine_image/Readme.md
}

# SLOW
module "vpc" {
  source = "./components/vpc"
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

variable "instance_types" {
  type = list(string)
  default = [
    # "t4g.nano", "t3a.nano", "t3.nano", "t2.nano",
    # "t4g.micro", "t3a.micro", "t3.micro", "t2.micro", "t1.micro",
    #"t4g.small", "t3a.small",
    #"t3.small",
    #"t2.small", not working
    #    "t2.medium" #
    "t3.medium"
  ]
}

variable "test_instance_types" {
  type = list(string)
  default = [
    # "t4g.nano", "t3a.nano", "t3.nano", "t2.nano",
    # "t4g.micro", "t3a.micro", "t3.micro", "t2.micro", "t1.micro",
    #"t4g.small", "t3a.small",
    #"t3.small",
    #"t2.small", not working
    #    "t2.medium" #
    #"t3.medium" # no instances  for now, this is commented out
  ]
}


module "roles" {
  source = "./components/roles"
  tags   = local.tags
}


module "lt_dynamic_ami_prod" {
  vpc_id            = local.vpc_id
  for_each          = toset(var.instance_types)
  instance_type     = each.key
  name              = "eliza-ami-${each.key}"
  security_group_id = module.security.internal_security_group_id
  ami_id            = local.ami_id
  key_name          = var.key_name
  tags = merge(local.tags, {
    environment = "production"
  })
  source                             = "./components/launch_template"
  iam_instance_profile_name          = module.roles.ssm_profile_name
  install_script                     = "/opt/eliza/api/just_run.sh"
  ssm_parameter_name_cw_agent_config = "arn:aws:ssm:${var.region}:${var.aws_account_id}:parameter/cloudwatch-agent/config"
  branch                             = "feature/ec2"
}

module "lt_dynamic_ami_test" {
  branch            = "feature/cloudwatch"
  vpc_id            = local.vpc_id
  for_each          = toset(var.instance_types)
  instance_type     = each.key
  name              = "eliza-ami-${each.key}"
  security_group_id = module.security.internal_security_group_id
  ami_id            = local.ami_id
  tags = merge(local.tags, {
    environment = "test"
  })
  source                             = "./components/launch_template"
  key_name                           = var.key_name #"mdupont-deployer-key"
  ssm_parameter_name_cw_agent_config = "arn:aws:ssm:${var.region}:${var.aws_account_id}:parameter/cloudwatch-agent/config/details"
  iam_instance_profile_name          = module.roles.ssm_profile_name
  install_script                     = "/opt/eliza/api/just_run.sh"
}


variable "dev_instance_types" {
  type = list(string)
  default = [
    # "t4g.nano", "t3a.nano", "t3.nano", "t2.nano",
    # "t4g.micro", "t3a.micro", "t3.micro", "t2.micro", "t1.micro",
    #"t4g.small", "t3a.small",
    #"t3.small",
    #"t2.small", not working
    #    "t2.medium" #
    #    "t3.small"
  ]
}

variable "dev2_instance_types" {
  type = list(string)
  default = [
    # "t4g.nano", "t3a.nano", "t3.nano", "t2.nano",
    # "t4g.micro", "t3a.micro", "t3.micro", "t2.micro", "t1.micro",
    #"t4g.small", "t3a.small",
    #"t3.small",
    #"t2.small", not working
    #    "t2.medium" #
    #"t3.medium"
  ]
}

module "lt_dynamic_ami_docker" {
  #branch            = "feature/squash2-docker"
  branch            = "feature/merge_latest_675"
  vpc_id            = local.vpc_id
  for_each          = toset(var.dev_instance_types)
  instance_type     = each.key
  name              = "eliza-docker-${each.key}"
  security_group_id = module.security.internal_security_group_id
  ami_id            = local.ami_id
  tags = merge(local.tags, {
    environment = "test"
  })
  source                             = "./components/launch_template_docker"
  key_name                           = var.key_name #"mdupont-deployer-key"
  ssm_parameter_name_cw_agent_config = "arn:aws:ssm:${var.region}:${var.aws_account_id}:parameter/cloudwatch-agent/config/details"
  iam_instance_profile_name          = module.roles.ssm_profile_name
  #install_script = "/opt/eliza/api/docker-boot.sh" this is called from ssm for a refresh
  install_script = "/opt/eliza/api/rundocker.sh"
}

module "lt_dynamic_ami_docker_normal" {
  #branch            = "feature/squash2-docker"
  branch            = "feature/merge_latest_675"
  vpc_id            = local.vpc_id
  for_each          = toset(var.dev2_instance_types)
  instance_type     = each.key
  name              = "eliza-docker-${each.key}"
  security_group_id = module.security.internal_security_group_id
  ami_id            = local.ami_id
  tags = merge(local.tags, {
    environment = "test"
  })
  source                             = "./components/launch_template_docker"
  key_name                           = var.key_name #"mdupont-deployer-key"
  ssm_parameter_name_cw_agent_config = "arn:aws:ssm:${var.region}:${var.aws_account_id}:parameter/cloudwatch-agent/config/details"
  iam_instance_profile_name          = module.roles.ssm_profile_name
  #install_script = "/opt/eliza/api/docker-boot.sh" this is called from ssm for a refresh
  install_script = "/opt/eliza/api/rundocker.sh"
}


# module "alb" {
#   count = 0 # none for now
#   source            = "./components/application_load_balancer"
#   domain_name       = local.domain
#   security_group_id = module.security.security_group_id # allowed to talk to internal
#   public_subnets = [
#     local.ec2_public_subnet_id_1,
#   local.ec2_public_subnet_id_2]
#   vpc_id = local.vpc_id
#   name   = local.name
# }
# output "alb" {
#   value = module.alb
# }


# module "asg_dynamic_new_ami" {
#   # built with packer
#   #count =0
#   tags                             = local.tags
#   vpc_id                           = local.vpc_id
#   image_id                         = local.new_ami_id
#   ec2_subnet_id                    = module.vpc.ec2_public_subnet_id_1
#   for_each                         = toset(var.instance_types)
#   aws_iam_instance_profile_ssm_arn = module.roles.ssm_profile_arn
#   source                           = "./components/autoscaling_group"
#   #  security_group_id   = module.security.internal_security_group_id
#   instance_type      = each.key
#   name               = "eliza-ami-${each.key}"
#   launch_template_id = module.lt_dynamic_ami_prod[each.key].launch_template_id
#   target_group_arn   = module.alb.prod_alb_target_group_arn
# }

# module "asg_dynamic_new_ami_test" {

#   # built with packer
#   for_each      = toset(var.test_instance_types)
#   tags          = merge(local.tags, local.dev_tags)
#   vpc_id        = local.vpc_id
#   image_id      = local.new_ami_id
#   ec2_subnet_id = module.vpc.ec2_public_subnet_id_1

#   aws_iam_instance_profile_ssm_arn = module.roles.ssm_profile_arn
#   source                           = "./components/autoscaling_group/spot"
#   #  security_group_id   = module.security.internal_security_group_id
#   instance_type      = each.key
#   name               = "test-eliza-ami-${each.key}"
#   launch_template_id = module.lt_dynamic_ami_test[each.key].launch_template_id
#   target_group_arn   = module.alb.test_alb_target_group_arn
# }

# module "asg_dynamic_new_ami_dev_spot" {
#   # built with packer
#   #  count =0
#   tags                             = merge(local.tags, local.dev_tags)
#   vpc_id                           = local.vpc_id
#   image_id                         = local.new_ami_id
#   ec2_subnet_id                    = module.vpc.ec2_public_subnet_id_1
#   for_each                         = toset(var.dev_instance_types)
#   aws_iam_instance_profile_ssm_arn = module.roles.ssm_profile_arn

#   source = "./components/autoscaling_group/spot"
#   #  security_group_id   = module.security.internal_security_group_id
#   instance_type      = each.key
#   name               = "docker-eliza-ami-${each.key}"
#   launch_template_id = module.lt_dynamic_ami_docker[each.key].launch_template_id
#   target_group_arn   = module.alb.dev_alb_target_group_arn

#   use_mixed_instances_policy = true
#   mixed_instances_policy = {
#     instances_distribution = {
#       on_demand_base_capacity                  = 0
#       on_demand_percentage_above_base_capacity = 0
#       spot_instance_pools                      = 1
#       spot_max_price                           = var.spot_max_price
#       #      spot_allocation_strategy                 = "capacity-optimized"
#     }

#     override = [
#       {
#         instance_requirements = {
#           cpu_manufacturers = ["amazon-web-services", "amd", "intel"]
#           #cpu_manufacturers                                       = ["amd"]
#           #local_storage_types                                     = ["ssd"]
#           max_spot_price_as_percentage_of_optimal_on_demand_price = 60
#           memory_gib_per_vcpu = {
#             min = 4
#             max = 12
#           }
#           memory_mib = {
#             min = 4096
#           },
#           vcpu_count = {
#             min = 2
#             max = 12
#           }
#         }
#       }
#     ]
#   }
#   instance_requirements = {
#   }
# }

module "asg_dynamic_new_ami_dev_normal" {
  # built with packer
  #  count =0

  tags                             = merge(local.tags, local.dev_tags)
  vpc_id                           = local.vpc_id
  image_id                         = local.ami_id
  ec2_subnet_id                    = module.vpc.ec2_public_subnet_id_1
  for_each                         = toset(var.dev2_instance_types)
  aws_iam_instance_profile_ssm_arn = module.roles.ssm_profile_arn

  source = "./components/autoscaling_group/spot"
  #  security_group_id   = module.security.internal_security_group_id
  instance_type      = each.key
  name               = "docker-eliza-ami-${each.key}"
  launch_template_id = module.lt_dynamic_ami_docker_normal[each.key].launch_template_id
#  target_group_arn   = module.alb.dev_alb_target_group_arn


}

output "security_group_id" {
  value = module.security.security_group_id
}

module "eliza" {
  source                     = "./mcs" # fixme rename to eliza
  branch =    "feature/reduce_modules_discord"
  #git_repo = "https://github.com/meta-introspector/eliza-MedicalCoderSwarm-deployment.git"
  git_repo = "https://github.com/meta-introspector/cloud-deployment-eliza/"
#  alb_target_group_arn       = module.alb.mcs_alb_target_group_arn
  ssm_profile_arn            = module.roles.ssm_profile_arn
  ec2_subnet_id              = module.vpc.ec2_public_subnet_id_1
  iam_instance_profile_name  = module.roles.ssm_profile_name
  key_name                   = var.key_name
  aws_account_id             = var.aws_account_id
  region                     = var.region
  internal_security_group_id = module.security.internal_security_group_id
  tags                       = local.tags
  ami_id                     = local.ami_id
  vpc_id                     = local.vpc_id
  name = "docker-mcs-ami"
}

# module "agent_dev" {
#   source                     = "./agent"
#   name = "agent-dev"
#   branch =    "feature/agent_dev"
#   git_repo = "https://github.com/jmikedupont2/eliza-MedicalCoderSwarm-deployment.git"
    
#   alb_target_group_arn       = module.alb.agent_dev_alb_target_group_arn
#   ssm_profile_arn            = module.roles.ssm_profile_arn
#   ec2_subnet_id              = module.vpc.ec2_public_subnet_id_1
#   iam_instance_profile_name  = module.roles.ssm_profile_name
#   key_name                   = var.key_name
#   aws_account_id             = var.aws_account_id
#   region                     = var.region
#   internal_security_group_id = module.security.internal_security_group_id
#   tags                       = local.tags
#   ami_id                     = local.ami_id
#   vpc_id                     = local.vpc_id

#   instance_types= [
#     "t3.medium"
#   ]
# }

output "vpc" {
  value = module.vpc
}

output "user_data_new" {
  value = module.lt_dynamic_ami_test["t3.medium"].user_data
}
output "user_data_docker" {
  value = ""
  #module.lt_dynamic_ami_docker_normal["t3.medium"].user_data
}

