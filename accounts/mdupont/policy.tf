# data "aws_iam_policy_document" "state_bucket_policy" {
#   statement {
#     effect = "Deny"
#     principal = "*"
#     action = "s3:*"
#     resource = "arn:aws:s3:::${var.state_bucket_id}/*"
#     condition {
#       bool {
#         aws_secure_transport = "false"
#       }
#     }
#   }

#   statement {
#     effect = "Allow"
#     principal = { service = "s3.amazonaws.com" }
#     action = "s3:PutObject"
#     resource = "arn:aws:s3:::${var.state_bucket_id}/*"
#     condition {
#       string_equals = {
#         aws_source_account = var.aws_account_id
#         s3_x_amz_acl = "bucket-owner-full-control"
#       }

#       arn_like = {
#         aws_source_arn = "arn:aws:s3:::${var.state_bucket_id}"
#       }
#     }
#   }
# }
