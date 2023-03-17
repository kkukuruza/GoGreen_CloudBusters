
# VARIABLES FROM JAS

# Variables for Instances

variable "web_instance_type" {
  description = "instance type for web tier"
  default     = ""
}

variable "app_instance_type" {
  description = "instance type app tier"
  default     = ""
}

variable "iam_instance_profile_arn" {
  description = "ARN of the IAM instance profile for ec2 instance"
  default     = ""
}