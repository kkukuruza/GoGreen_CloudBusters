#cloudfront

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "CloudFront origin access identity"
}

resource "aws_cloudfront_distribution" "distribution" {
  enabled             = var.enabled
  origin {
    domain_name = aws_s3_bucket.bucket.website_endpoint
    origin_id   = "S3-${aws_s3_bucket.bucket.id}"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  default_root_object = var.default_root_object
  price_class         = var.price_class
  default_cache_behavior {
    target_origin_id = "S3-${aws_s3_bucket.bucket.id}"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}