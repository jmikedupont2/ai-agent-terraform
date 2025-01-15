# https://github.com/cloudposse/terraform-aws-codebuild.githttps://github.com/cloudposse/terraform-aws-codebuild.git
# module "build" {
#   source = "cloudposse/codebuild/aws"
#   version     = "2.0.2"
#   # Optional extra environment variables
#   environment_variables = [

#   ]
# }


module "build" {
  source = "cloudposse/cicd/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.20.0"
  namespace   = "main"
  stage       = "staging"
  name        = "arm64-tokenizers"
  enabled             = true
  # Application repository on GitHub
#  github_oauth_token  = "(Required) <GitHub Oauth Token with permissions to access private repositories>"
#  repo_owner          = "<GitHub Organization or Person name>"
#  repo_name           = "<GitHub repository name of the application to be built and deployed to Elastic Beanstalk>"
#  branch              = "<Branch of the GitHub repository>"

  # http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html
  # http://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html
  build_compute_type  = "BUILD_GENERAL1_SMALL"
  privileged_mode     = true
  region              = "us-east-2"
  image_repo_name     = "nodemodules/tokenizer"
  image_tag           = "latest"

   build_image         = "aws/codebuild/amazonlinux2-aarch64-standard:3.0"
   build_type  = "ARM_CONTAINER"
   build_timeout       = 60
  
#   image_repo_name     = "nodemodules/tokenizer"
#   image_tag           = "latest"


}
