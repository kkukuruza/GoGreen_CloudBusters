variable "kms_key_alias" {
  description = "The alias for the KMS key."
  default     = "alias/admin-kms-key"
}

variable "kms_key_description" {
  description = "The description for the KMS key."
  default     = "KMS key for admin-specific encryption."
}

variable "user_arn" {
  description = "The ARN of the IAM user to attach the KMS key."
  type        = map(string)
}
