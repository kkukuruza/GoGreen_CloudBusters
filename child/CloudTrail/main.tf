resource "aws_cloudtrail" "gogreen_cloudtrail" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.bucket
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = var.enable_log_file_validation

  depends_on = [aws_s3_bucket_policy.cloudtrail_bucket_policy]
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail_bucket_lifecycle" {

  rule {
    id = "CloudTrail Rule"
    status = "Enabled"

    transition {
      days          = var.transition_days
      storage_class = "GLACIER"
    }
  }

  bucket = aws_s3_bucket.cloudtrail_bucket.id
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:GetBucketAcl"
        Effect = "Allow"
        Resource = aws_s3_bucket.cloudtrail_bucket.arn
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      },
      {
        Action = "s3:PutObject"
        Effect = "Allow"
        Resource = "${aws_s3_bucket.cloudtrail_bucket.arn}/*"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
} 

# CODE FROM JAS

