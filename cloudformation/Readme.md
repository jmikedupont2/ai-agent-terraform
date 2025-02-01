
aws cloudformation validate-template --template-body file://ec2.yml

terraform apply -auto-approve -var-file .tfvars 


[![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-west-1#/stacks/new?stackName=zos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer&templateURL=https://s3.amazonaws.com/zos-solfunmeme-tine-cf-template/zos-solfunmeme-tine-the-introspector-is-not-eliza-stack-template-one-click-installer.yaml)
