
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "region" {}
locals { ami_name = "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-minimal-*" }
data "aws_ami" "ami" { # slow
  most_recent = true
  owners      = [679593333241] # ubuntu
  name_regex  = "^${local.ami_name}"
}

locals {
  template_url = "https://${var.region}.console.aws.amazon.com/cloudformation/home?region=${var.region}#/stacks/quickcreate?templateURL=https%3A%2F%2Fs3.amazonaws.com%2Fzos-solfunmeme-tine-cf-template%2Fzos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer.yaml&stackName=zos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer&param_S3BucketPattern=tine_agent_*&param_GroqKey=&param_TokenizerImage=h4ckermike%2Felizaos-eliza%3Afeature-arm64_fastembed&param_TwitterPassword=&param_NameTag=tine-dev&param_AgentCodeName=tine_agent_4&param_SSMParameterPattern=tine_agent_*&param_TwitterUserName=&param_LaunchTemplateVersion=1&param_TwitterEmail=&param_AgentImage=h4ckermike%2Felizaos-eliza%3Afeature-arm64_fastembed&param_AmiId=${data.aws_ami.ami.id}"
}

output "full_template_url" {
  value = local.template_url
}

output "full_html_url" {
  value = "* ${var.region} [![Launch ${var.region} Stack](${local.template_url})"

}

output "ami_id" {
  value = data.aws_ami.ami.id
}
