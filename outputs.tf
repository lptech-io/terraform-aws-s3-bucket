output "arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The S3 bucket ARN"
}

output "id" {
  value       = aws_s3_bucket.bucket.id
  description = "The name of S3 bucket"
}

output "region" {
  value       = aws_s3_bucket.bucket.region
  description = "The AWS region in which the S3 bucket is deployed"
}
