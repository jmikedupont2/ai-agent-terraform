## 2026-03-30 - Enforce IMDSv2 and Root Block Encryption on EC2 Resources
**Vulnerability:** Unencrypted root storage volumes and unconstrained Instance Metadata Service (IMDSv1) allowed potential SSRF exploitation to retrieve IAM role credentials and data exposure at rest.
**Learning:** Legacy or template Terraform configurations for EC2 instances often omit explicit `metadata_options` and `root_block_device` blocks, leaving instances defaulting to IMDSv1 and unencrypted root disks.
**Prevention:** Always enforce `metadata_options { http_tokens = "required" }` and `root_block_device { encrypted = true }` across all `aws_instance` definitions.
