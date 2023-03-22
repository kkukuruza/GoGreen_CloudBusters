variable "rate_limit" {
  description = "Rate limit for IP addresses (requests per 5 minutes)."
  default     = 500
}

variable "alb_arn" {
  description = "ARN of the load balancer to associate with the WAF WebACL."
  type        = string
}
