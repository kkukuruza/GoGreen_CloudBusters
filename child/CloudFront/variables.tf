variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to use for the CloudFront distribution"
}

variable "default_root_object" {
  type        = string
  description = "The default root object for the CloudFront distribution"
  default     = "index.html"
}

variable "price_class" {
  type        = string
  description = "The price class for the CloudFront distribution"
  default     = "PriceClass_100"
}

variable "enabled" {
  type        = bool
  description = "Whether the CloudFront distribution is enabled"
  default     = true
}