# ------------------------------------------------------
# 1. אבטחת דיסקים (EBS) - הצפנה גלובלית
# ------------------------------------------------------
# מכריח את AWS להצפין כל דיסק חדש שנוצר באזור
resource "aws_ebs_encryption_by_default" "ebs_global_encryption" {
  enabled = true
}

# ------------------------------------------------------
# 2. אבטחת שרתים (EC2) - אכיפת IMDSv2
# ------------------------------------------------------
# חוסם גישה ישנה למטא-דאטה של השרת ודורש שימוש בטוקן
resource "aws_ec2_instance_metadata_defaults" "enforce_imdsv2_globally" {
  http_tokens = "required"
}

# ------------------------------------------------------
# 3. אבטחת חומרים וקבצים מועלים (S3)
# ------------------------------------------------------
# חוסם גישה ציבורית ברמת החשבון כולו לכל הבאקטים,
# כדי ששום חומר שמועלה לא יהיה נגיש בטעות החוצה
resource "aws_s3_account_public_access_block" "secure_uploads_globally" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
