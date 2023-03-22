variable "asg_name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "vpc_zone_identifier" {
  type = list(string)
  description = "A list of subnet IDs to associate with the Auto Scaling group"
}

variable "min_size" {
  type = number
  default = 1
}

variable "max_size" {
  type = number
  default = 3
}

variable "desired_capacity" {
  type = number
  default = 2
}

variable "launch_template_id" {
  type = string
  default = ""
}

variable "target_group_arns" {
  type        = list(string)
  default     = []
  description = "A list of target group ARNs to associate with the Auto Scaling group"
}

variable "asg_tag" {
  type = string
}