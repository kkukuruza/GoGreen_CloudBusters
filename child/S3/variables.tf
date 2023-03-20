variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS key to be used for encryption"
}

variable "versioning" {
  type        = string
  default = "Enabled"
}

