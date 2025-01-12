variable name {}
variable branch {}

variable git_repo {
  default = "https://github.com/jmikedupont2/swarms-MedicalCoderSwarm-deployment.git"
}

variable "ec2_subnet_id" {}
#variable "alb_target_group_arn" {}
variable "aws_account_id" {}
variable "vpc_id" {}
# FIXME security, we use the ami of swarms for speed but want to split
variable "ami_id" {}
# FIXME security, we use the sg of swarms for speed but want to split
variable "internal_security_group_id" {}

# FIXME security, we use the profile of swarms for speed but want to split
variable "iam_instance_profile_name" {}
variable "ssm_profile_arn" {}
variable "key_name" {}
variable "region" {}
variable "tags" {}

variable "instance_types" {
  type = list(string)
  default = [
    #"t3.small",
    #    "t2.medium" #
    #"t3.medium"
    #    "t4g.nano",
    #"t3a.nano", "t3.nano", "t2.nano",  connection refused
    #    "t4g.micro",
    #"t3a.micro",
    #"t3.micro",
    #"t2.micro", failed to boot docker
    #"t1.micro",
#    "t4g.small",
    "t3a.small",
    "t3.small",
    "t2.small", 
    "t3.medium"  # works for sure
    # fixme pass this list in
  ]
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

  key_name                           = var.key_name #"mdupont-deployer-key"
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
