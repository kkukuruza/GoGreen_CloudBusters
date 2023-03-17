variable "cloudtrail_name" {
  description = "The name of the AWS CloudTrail"
  type        = string
}

variable "kms_key" {
  description = "The CMK to encrypt CloudTrail logs"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket used for CloudTrail logs"
  type        = string
}

variable "include_global_service_events" {
  description = "Whether to include global service events in the trail"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Whether the trail is created in all regions or current region only"
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  description = "Enable log file integrity validation"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Whether to force the deletion of the S3 bucket when destroying the module"
  type        = bool
  default     = false
}

variable "transition_days" {
  description = "Number of days to wait before transitioning the logs to the Glacier storage class"
  type        = number
  default     = 30
}
