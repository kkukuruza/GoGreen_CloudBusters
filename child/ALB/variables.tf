variable "alb_name" {
  type = string
}

variable "subnets" {
  type = list(string)
  description = "A list of subnet IDs for the load balancer"
}

variable "vpc_id" {
  type = string
  description = "The VPC ID where the load balancer will be created"
}

variable "security_group_ids" {
  type = list(string)
  description = "A list of security group IDs for the load balancer"
}

variable "scheme" {
  type = bool
  description = "The scheme of the load balancer, either 'internet-facing' or 'internal'"
  default = false
}

variable "target_group_port" {
  type = number
  description = "The port to associate with the target group"
}

variable "tg_name" {
  type = string
}