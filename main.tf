data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Name = var.bucket_name
  }
}

# Disable bucket ACLs and use bucket policies instead
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = var.public_access_configuation.block_public_acls
  block_public_policy     = var.public_access_configuation.block_public_policy
  ignore_public_acls      = var.public_access_configuation.ignore_public_acls
  restrict_public_buckets = var.public_access_configuation.restrict_public_buckets
}

# Enforce encryption on the bucket. Use the default AWS/S3 key if no KMS key is provided
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key == null ? "AES256" : "aws:kms"
      kms_master_key_id = var.kms_key == null ? "" : var.kms_key
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_logging" "logging_configuration" {
  count = var.logging_configuration.enabled ? 1 : 0

  bucket        = aws_s3_bucket.bucket.id
  target_bucket = var.logging_configuration.bucket_name
  target_prefix = var.logging_configuration.prefix
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}
