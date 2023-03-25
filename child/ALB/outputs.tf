
output "alb_arn" {
  value = aws_lb.go_green_alb.arn
}

output "target_group_arns" {
  value = aws_lb_target_group.alb_tg.arn
}

output "alb_hosted_zone_id" {
  value = aws_lb.go_green_alb.zone_id
}

output "alb_dns_name" {
  value = aws_lb.go_green_alb.dns_name
}