resource "aws_s3_bucket" "go_green" {
  bucket = var.bucket_name

}

resource "aws_s3_bucket_server_side_encryption_configuration" "go_green" {
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }

  bucket = aws_s3_bucket.go_green.id
}


resource "aws_s3_bucket_acl" "go_green" {
  bucket = aws_s3_bucket.go_green.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "go_green" {
  bucket = aws_s3_bucket.go_green.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "go_green" {
  rule {
    id      = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  bucket = aws_s3_bucket.go_green.id
}