variable "alarm_description" {
  type        = string
  description = "Description of the CloudWatch alarm"
  default     = "HTTP/400 Error rate is too high"
}

variable "error_threshold" {
  type        = number
  description = "The number of HTTP 400 errors per minute above which the alarm should trigger"
  default     = 100
}

variable "metric_name" {
  type        = string
  description = "The name of the CloudWatch metric"
  default     = "HTTP400Errors"
}

variable "metric_namespace" {
  type        = string
  description = "The namespace of the CloudWatch metric"
  default     = "MyApp/HTTP"
}

variable "log_group_name" {
  type        = string
  description = "The name of the CloudWatch Logs log group to filter"
}

variable "sns_topic" {
  type        = string
  description = "sns_topic_name"
}
