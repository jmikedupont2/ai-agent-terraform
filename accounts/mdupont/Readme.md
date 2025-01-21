removed 
```
terraform state rm  "module.codebuild.module.build.random_string.bucket_prefix[0]"
terraform state rm  "module.codebuild.module.build.aws_iam_role_policy_attachment.default[0]"
terraform state rm  "module.codebuild.module.build.aws_iam_role.default[0]"
terraform state rm  "module.codebuild.module.build.aws_iam_policy.default[0]"
```
