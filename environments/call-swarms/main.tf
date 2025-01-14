# from
# https://github.com/shaikis/terraform-aws-ssm-document.git

resource "aws_ssm_document" "deploy" {
  name            = "deploy"
  document_format = "YAML"
  document_type   = "Command"
  content         = file("deploy.yaml")
  tags = {env = "test"}
}

