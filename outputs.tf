output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The S3 bucket ARN"
}

output "bucket_name" {
  value       = aws_s3_bucket.bucket.id
  description = "The name of S3 bucket"
}

output "bucket_region" {
  value       = aws_s3_bucket.bucket.region
  description = "The AWS region in which the S3 bucket is deployed"
}
