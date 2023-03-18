variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone."
  type        = string
  default = "cloudbusters.click"
}

variable "subdomain_name" {
  description = "The subdomain name for the Route 53 record."
  type        = string
  default = "files"
}

variable "alb_dns_name" {
  description = "The dns name for the Public ALB."
  type        = string
  default = ""
}

variable "alb_zone_id" {
  description = "The hosted zone id for the Public ALB."
  type        = string
  default = ""
}

variable "cloudfront_domain_name" {
  description = "The domain name for the CloudFront."
  type        = string
  default = ""
}

variable "cloudfront_hosted_zone_id" {
  description = "The hosted zone id for the CloudFront."
  type        = string
  default = ""
}