# status

1. deployed to us-east-2
2. want to deploy second test instance 
3. dont want to disturb existing servers.
4. create second instance of agent module with new branch for testing.

# one click installer plan

Using cloudformation
https://github.com/meta-introspector/cfn-tf-meta-introspector/issues/1 still need someone to try this

we want a step by step instructions to setup your aws
and then they click on this
https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=tfcfn-custom-type-resources&templateURL=https://s3.amazonaws.com/ianmckay-us-east-1/cfn-tf-custom-types/template.yml

and then we port our repo https://github.com/meta-introspector/ai-agent-terraform/tree/feature/aitokenteam into running inside of cloudformation

TODO : Great asset
    transform our terraform resources into cloudformation yaml to use tf provider
	we could deploy azure or gcp from aws in terraform.
	
For the mean time, we will deploy terraform.

Another alternative is 
https://runatlantis.io/

# solfun meme branch of ai-agent terraform

This will deploy the :
1. solfunmeme dao agent to work for the solfunmeme dao
1.1. (eliza)

2. solfunmeme web server(done)
2.1 to vercel 
2.1.1. (done, manually not terraformed) 
2.2 to aws (TBD)
https://codeberg.org/introspector/SOLFUNMEME/issues/25

stakeholders will login via the phantom wallet compatible web app with wallet and be able to vote on important decisions :

3. terraform to admin discord :
who is admin in 
	telegram
	discord
	
what versions of what bots with what permissions do we have in telegram
what software projects are important to work on
what marketing and listing should we persue
etc.
This will be the core of the dao, I will use this as my oracle for every day decisions and try and act in the best interest of the team and hope all of us will.

We are going to build something amazing, I have tons of work ready, many ideas ready to launch when we have this running.

3. the dns records to namecheap. 
3.1 done manually
3.2 add terraform

4. cognito with web3 Integration
https://codeberg.org/introspector/SOLFUNMEME/issues/5

## agent spec : 
 
What the agent will do

resolve tickets :
	in codeberg and 
	in github and 
	later in gitlab, jira
	
but talk in: 
	discord, 
	telegram, 
	twitter it should 
	
the agent will update the main web page as well.
we will deploy the main page to terraform as well. 

LANGUAGE API:
Deploy open lite llm server, connect to multiple backends.

# terraform-template

```
git clone https://github.com/aitokenteam/ai-agent-terraform.git
cd ai-agent-terraform/accounts/AI_Token_Team/
git checkout feature/aitokenteam

terraform init

aws ecr create-repository --repository-name agent/eliza
aws ecr create-repository --repository-name nodemodules/sql-lite-vec

aws ssm put-parameter     --name "agent_openai_key"  --value "${OPENAI_API_KEY}" --type String

terraform apply --target module.ssm_observer.aws_ssm_parameter.cw_agent_config --target module.ssm_observer.aws_ssm_parameter.cw_agent_config_details
terraform apply 
```

Terraform project template for deploying infrastructure across multiple environments and regions, following best practices with modular structure and automated syntax checks (GitHub Actions)

## Installation

1. setup aws account
2. create user with administrator privledges for terraform/tofu
	
Directly attach Policy name 	`AdministratorAccess` to user 
replace <USERNAME> in the following url
`https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-2#/users/details/<USERNAME>?section=permissions`

create access key
https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-2#/users/details/mdupont/create-access-key

~/.aws/credentials

aws cli install 
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

`aws configure`

opentofu install
https://opentofu.org/docs/intro/install/

Go to ami catalog in your region:
https://us-west-1.console.aws.amazon.com/ec2/home?region=us-west-1#AMICatalog:

Search for "ubuntu-noble-24.04-amd64-minimal" in the third tab "aws marketplace amis"

Accept license.

## Status report

Currently we are building out a dev infrastructure using our existing code
and adding in a docker target, this has the advantage that we can build and test
the docker outside of aws and then deploy it easily.

## Repo structure

```
terraform-template/                   # Root directory of the Terraform template repository
├── README.md                         # Project documentation and overview
├── accounts
│   ├── swarms                        # the main swarms account
├── environments
│   ├── swarms-aws-agent-api
│   │   ├── dev                       # Development environment configuration for the demo-azure-vm setup
│   │   │   └── us-east-1
├── modules                           # Directory containing reusable Terraform modules
│   ├── swarms
```

to ss to the server 
`aws ssm start-session --target i-0e156165e86473c93 --profile mdupont --region us-east-2`

to install secret
`aws ssm put-parameter     --name "agent_openai_key"  --value "${OPENAI_API_KEY}" --type String`

If you get this error:
```
│ Error: reading SSM Parameter (arn:aws:ssm:us-east-1:AKIA4SYAMCQ5MMLC6NU3:parameter/cloudwatch-agent/config/details): operation error SSM: GetParameter, https response error StatusCode: 400, RequestID: 159177cb-91f0-4c2e-a354-07cdc2e64041, api error ValidationException: Invalid Account Id in: arn:aws:ssm:us-east-1:AKIA4SYAMCQ5MMLC6NU3:parameter/cloudwatch-agent/config/details
│   with module.eliza_server.module.eliza.module.lt_docker["t3a.small"].data.aws_ssm_parameter.cw_agent_config,
│   on ../../environments/eliza-agent-api/components/launch_template_docker_mcs/main.tf line 77, in data "aws_ssm_parameter" "cw_agent_config":
│   77: data "aws_ssm_parameter" "cw_agent_config" {
```
we need to apply this first:
`tofu apply --target module.ssm_observer.aws_ssm_parameter.cw_agent_config --target module.ssm_observer.aws_ssm_parameter.cw_agent_config_details`

check the ECR images 
`aws ecr list-images --region us-east-2 --repository-name swarms/mcs`

To login from docker to ecr
`docker login -u AWS -p $(aws ecr get-login-password --region us-east-2) 767503528736.dkr.ecr.us-east-2.amazonaws.com'       767503528736.dkr.ecr.us-east-2.amazonaws.com/agent/eliza:latest`

# setup 
we dont use terraform for the ecr or the secrets because they will change so often here are the simple aws scripts for them.

`aws ecr create-repository --repository-name agent/eliza`

`set_secrets.sh` calls
`aws ssm put-parameter     --name "agent_openai_key"  --value "${OPENAI_API_KEY}" --type String`

## connecting with server
`ssh-ssm.py` to find the server
 
for example:
`aws ssm start-session --target i-0e156165e86473c93 --profile mdupont --region us-east-2`

## terraform-aws-oidc-github
https://github.com/jmikedupont2/terraform-aws-oidc-github

in my time 2024/12/18/terraform-aws-oidc-github on branch
run the tofu apply in the example after editing the variables and files.

# debug
`pnpm start:debug --characters=./characters/eliza.character.json`
start direct client here 

# set the az 
	 #~/terraform/accounts/AI_Token_Team/main.tf
edit 
   aws_availability_zones = ["us-west-1a","us-west-1b","us-west-1c"]

if you ge the errror:
00000003]
module.ssm_setup.module.ssm.aws_s3_bucket_lifecycle_configuration.access_log_bucket: Creation complete after 32s [id=ai-token-team-session-access-logs-20250113203757298300000002]
╷
│ Error: creating EC2 Subnet: operation error EC2: CreateSubnet, https response error StatusCode: 400, RequestID: 05eeaa25-0855-4d71-8945-04b0d6233520, api error InvalidParameterValue: Value (us-west-1b) for parameter availabilityZone is invalid. Subnets can currently only be created in the following availability zones: us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1e, us-east-1f.
│ 
│   with module.eliza_server.module.vpc.module.vpc.aws_subnet.public[1],
│   on .terraform/modules/eliza_server.vpc.vpc/main.tf line 98, in resource "aws_subnet" "public":
│   98: resource "aws_subnet" "public" {
│ 


nter a value: yes

# key pair
module.eliza_server.module.eliza.module.asg["t3a.small"].module.autoscaling.aws_autoscaling_group.this[0]: Creating...
╷
│ Error: creating Auto Scaling Group (docker-agent-ami-t3a.small-20250113205357496400000001): operation error Auto Scaling: CreateAutoScalingGroup, https response error StatusCode: 400, RequestID: 380d0f57-bf60-40fd-ace6-d86563107c85, api error ValidationError: You must use a valid fully-formed launch template. The key pair  does not exist
│ 
│   with module.eliza_server.module.eliza.module.asg["t3a.small"].module.autoscaling.aws_autoscaling_group.this[0],
│   on .terraform/modules/eliza_server.eliza.asg.autoscaling/main.tf line 347, in resource "aws_autoscaling_group" "this":
│  347: resource "aws_autoscaling_group" "this" {
│
edit 
~/terraform/environments/eliza-agent-api/components/keypairs/main.tf

resource "aws_key_pair" "deployer" {
   key_name   = "ai-token-deployer-key"
   public_key = "<insert your personal cat ~/.ssh/id_pub.rsa"
}


# connect via ssm

switch to su 
`sudo su -`

`cd /opt/agent `
`git pull `
`git fetch --all`
`docker ps`
`cat /var/log/cloud-init-output`
`cat /var/log/agent-docker`
`cat /etc/systemd/system/agent-docker.service`
`bash /opt/agent/rundocker.sh`
`aws sts get-caller-identity`

instance/ security/ security group,
click on security group 
edit inbound rules, 
add new rule, do not edit existing.
custom tcp, port 3000, source (my ip),blank
use my eliza starter
https://github.com/meta-introspector/eliza-starter

docker inspect agent-docker.service
docker logs agent-docker.service
lsof -iTCP:3000

"TINE-IntrospectorIsNotEliza"


# terraform partial apply

terraform plan , edit to list of items you want to apply in targets.txt

for x in `cat targets.txt`; do echo "--target \"$x\""; done  | sed -e "s;\n;;g" | tr -d '\n'

^Jmdupont@mdupont-G470:~/terraform/accounts/mdupont$ for x in `cat targets.txt`; do echo "--target \"$x\""; done  | sed -e "s;\n;;g" | tr -d '\n'
for x in `cat targets.txt`; do echo " --target '$x'"; done  | sed -e "s;\n;;g" | tr -d '\n'^J

terraform apply  --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_group.this[0]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["avg-cpu-policy-greater-than-50"]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["predictive-scaling"]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["scale-out"]' --target 'module.eliza_test_server.module.eliza.module.lt_docker["t4g.small"].aws_launch_template.ec2_launch_template' --target 'module.eliza_test_server.module.roles.aws_iam_instance_profile.ssm' --target 'module.eliza_test_server.module.roles.aws_iam_policy.default' --target 'module.eliza_test_server.module.roles.aws_iam_role.ssm' --target 'module.eliza_test_server.module.roles.aws_iam_role_policy_attachment.AmazonSSMManagedEC2InstanceDefaultPolicy' --target 'module.eliza_test_server.module.roles.aws_iam_role_policy_attachment.SSM-role-policy-attach' --target 'module.eliza_test_server.module.roles.aws_iam_role_policy_attachment.default' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[2]'


store plan
```
terraform plan -no-color  >  plan.txt
```
# wait for it to finish

#grep create  plan.txt | cut -d" " -f4 > targets.txt
grep create  plan.txt | cut -d" " -f4  | grep module > targets.txt
#terraform apply $(for x in `cat targets.txt`; do echo " --target '$x'"; done  | sed -e "s;\n;;g" | tr -d '\n'^J)


#for x in `cat targets.txt`; do echo " --target '$x'"; done  | sed -e "s;\n;;g" | tr -d '\n'^J^J 

for x in `cat targets.txt`; do echo " --target '$x'"; done  | sed -e "s;\n;;g" | tr -d '\n'^J^J  > tt 2> tt2

terraform apply $(for x in `cat targets.txt`; do echo " --target '$x'"; done  | sed -e "s;\n;;g" | tr -d '\n'^J^J )

terraform apply  --target 'module.ssm_observer2.aws_iam_instance_profile.monitoring_profile' 

for x in `cat targets.txt`; do echo " --target '$x'"; done  | sed -e "s;\n;;g" | tr -d '\n'^J^J 


#--target 'module.eliza_test_server.module.eliza.module.lt_docker["t4g.small"].aws_launch_template.ec2_launch_template' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group.this_name_prefix[0]' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group_rule.egress_rules[0]' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group_rule.ingress_rules[0]' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group_rule.ingress_rules[1]' --target 'module.eliza_test_server.module.security.module.asg_sg_internal.aws_security_group.this_name_prefix[0]' --target 'module.eliza_test_server.module.security.module.asg_sg_internal.aws_security_group_rule.egress_rules[0]' --target 'module.eliza_test_server.module.security.module.asg_sg_internal.aws_security_group_rule.ingress_with_source_security_group_id[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_default_network_acl.this[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_default_route_table.default[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_default_security_group.this[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_internet_gateway.this[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route.public_internet_gateway[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_vpc.this[0]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_group.this[0]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["avg-cpu-policy-greater-than-50"]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["predictive-scaling"]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["scale-out"]'

# remove some junk sorry

terraform apply  --target 'module.ssm_observer2.aws_iam_instance_profile.monitoring_profile' --target 'module.ssm_observer2.aws_iam_role.ec2_monitoring_role' --target 'module.ssm_observer2.aws_iam_role.maintenance_window_role' --target 'module.ssm_observer2.aws_iam_role_policy_attachment.cloudwatch_agent_policy' --target 'module.ssm_observer2.aws_iam_role_policy_attachment.maintenance_window_policy' --target 'module.ssm_observer2.aws_iam_role_policy_attachment.ssm_policy' --target 'module.ssm_observer2.aws_ssm_maintenance_window_task.patch_task' --target 'module.eliza_test_server.module.eliza.module.lt_docker["t4g.small"].aws_launch_template.ec2_launch_template' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group.this_name_prefix[0]' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group_rule.egress_rules[0]' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group_rule.ingress_rules[0]' --target 'module.eliza_test_server.module.security.module.asg_sg.aws_security_group_rule.ingress_rules[1]' --target 'module.eliza_test_server.module.security.module.asg_sg_internal.aws_security_group.this_name_prefix[0]' --target 'module.eliza_test_server.module.security.module.asg_sg_internal.aws_security_group_rule.egress_rules[0]' --target 'module.eliza_test_server.module.security.module.asg_sg_internal.aws_security_group_rule.ingress_with_source_security_group_id[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_default_network_acl.this[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_default_route_table.default[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_default_security_group.this[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_internet_gateway.this[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route.public_internet_gateway[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_route_table_association.public[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.private[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[0]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[1]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_subnet.public[2]' --target 'module.eliza_test_server.module.vpc.module.vpc.aws_vpc.this[0]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_group.this[0]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["avg-cpu-policy-greater-than-50"]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["predictive-scaling"]' --target 'module.eliza_test_server.module.eliza.module.asg["t4g.small"].module.autoscaling.aws_autoscaling_policy.this["scale-out"]'


