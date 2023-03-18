resource "aws_route53_zone" "go_green" {
  name = var.domain_name
}

resource "aws_route53_record" "alb" {
  zone_id = aws_route53_zone.go-green.zone_id
  name    = var.domain_name 
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cloudfront" {
  zone_id = aws_route53_zone.go_green.zone_id
  name    = "${var.subdomain_name}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
