variable "sns_topic_name" {
  description = "The name of the SNS topic to create"
}

variable "endpoint" {
  type        = string
  description = "admins_email"
}

variable "protocol" {
  type        = string
  description = "protocol_type"
  default = "email"
}
