variable "sns_topic_name" {
  description = "The name of the SNS topic to create"
  default = "400HTTPErrors"
}

variable "endpoint" {
  type        = string
  description = "admins_email"
  default = "aurorasezinlawrence@gmail.com"
}

variable "protocol" {
  type        = string
  description = "protocol_type"
  default = "email"
}
