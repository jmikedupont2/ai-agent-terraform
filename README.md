# terraform-template

```
git clone https://github.com/aitokenteam/ai-agent-terraform.git
cd ai-agent-terraform/accounts/AI_Token_Team/
git checkout feature/aitokenteam

tofu init

aws ecr create-repository --repository-name agent/eliza

aws ssm put-parameter     --name "agent_openai_key"  --value "${OPENAI_API_KEY}" --type String

tofu apply --target module.ssm_observer.aws_ssm_parameter.cw_agent_config --target module.ssm_observer.aws_ssm_parameter.cw_agent_config_details
tofu apply 
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

if you ge the errro :
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

