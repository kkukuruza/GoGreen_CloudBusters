resource "aws_lb" "go_green_alb" {
  name               = var.name
  internal           = var.scheme 
  load_balancer_type = "application"

  security_groups = var.security_group_ids
  subnets         = var.subnets
}

resource "aws_lb_target_group" "alb_tg" {
 name     = "${var.name}-tg"
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path    = "/"
  }
}