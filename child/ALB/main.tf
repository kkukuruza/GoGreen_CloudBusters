resource "aws_lb" "go_green_alb" {
  name               = "ALB-${var.alb_name}-tier"
  internal           = var.scheme 
  load_balancer_type = "application"

  security_groups = var.security_group_ids
  subnets         = var.subnets
}

resource "aws_lb_target_group" "alb_tg" {
 name     = "${var.tg_name}-tg"
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path    = "/"
  }
}

resource "aws_lb_listener" "go_green_listener" {
  load_balancer_arn = aws_lb.go_green_alb.arn
  port              = 80 
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}