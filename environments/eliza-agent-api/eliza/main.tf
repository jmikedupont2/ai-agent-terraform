variable name {}
#variable ami_name {}
variable branch {}
variable git_repo {}

variable "ec2_subnet_id" {}
#variable "alb_target_group_arn" {}
variable "aws_account_id" {}
variable "vpc_id" {}
variable "ami_id" {}
variable "internal_security_group_id" {}
variable "iam_instance_profile_name" {}
variable "ssm_profile_arn" {}
#variable "key_name" {}
variable "region" {}
variable "tags" {}

variable "instance_types" {
  type = list(string)
}

module "lt_docker" {
  source            = "../components/launch_template_docker_mcs"
  branch            = var.branch
  vpc_id            = var.vpc_id
  for_each          = toset(var.instance_types)
  instance_type     = each.key
  name              = "agent-docker-${each.key}"
  security_group_id = var.internal_security_group_id
  ami_id            = var.ami_id
  git_repo          = var.git_repo
  app_name          = "agent" # used to construct /opt/agent for where we install to
  tags = merge(var.tags, {
    environment = "agent"
  })

#  key_name                           = var.key_name #"mdupont-deployer-key"
  ssm_parameter_name_cw_agent_config = "arn:aws:ssm:${var.region}:${var.aws_account_id}:parameter/cloudwatch-agent/config/details"
  iam_instance_profile_name          = var.iam_instance_profile_name
  #install_script = "/opt/agent/api/docker-boot.sh" this is called from ssm for a refresh
  install_script = "/opt/agent/rundocker.sh"
}



module "asg" {
  source                           = "../components/autoscaling_group/spot"
  tags                             = var.tags
  vpc_id                           = var.vpc_id
  image_id                         = var.ami_id
  ec2_subnet_id                    = var.ec2_subnet_id
  for_each                         = toset(var.instance_types)
  aws_iam_instance_profile_ssm_arn = var.ssm_profile_arn


  #  security_group_id   = module.security.internal_security_group_id
  instance_type      = each.key
  name               = "${var.name}-${each.key}"
  launch_template_id = module.lt_docker[each.key].launch_template_id
#  target_group_arn   = var.alb_target_group_arn
}
