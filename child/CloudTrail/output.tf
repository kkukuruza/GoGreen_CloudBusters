output "cloudtrail_id" {
  description = "The ID of the CloudTrail"
  value       = aws_cloudtrail.gogreen_cloudtrail.id
}

output "s3_bucket_id" {
  description = "The ID of the S3_bucket used for CloudTrail logs"
value = aws_s3_bucket.cloudtrail_bucket.id
}

output "s3_bucket_arn" {
description = "The ARN of the S3 bucket used for CloudTrail logs"
value = aws_s3_bucket.cloudtrail_bucket.arn
}
