#TASK:write terraform packer for ubuntu python fastapi server with custom git modules

#To create a Terraform configuration using Packer for an Ubuntu-based FastAPI server with custom Git modules, you'll need to follow a few steps. Below is a concise example of how to structure your Packer template and Terraform files.

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Ubuntu's account ID
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "fastapi_server_test_instance" {
  count         = var.test_server_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }

  # add in this user data
  tags = {
    Name = "FastAPI Server"
  }
}

