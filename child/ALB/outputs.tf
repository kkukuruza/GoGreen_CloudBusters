
output "alb_arn" {
  value = aws_lb.go_green_alb.arn
}

output "target_group_arns" {
  value = aws_lb_target_group.alb_tg.arn
}