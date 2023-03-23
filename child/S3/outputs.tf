output "bucket_arn" {
  value = aws_s3_bucket.go_green.arn
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket.go_green.bucket_regional_domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.go_green.bucket
}
