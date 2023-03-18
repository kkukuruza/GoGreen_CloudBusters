resource "aws_autoscaling_group" "go_green" {
  name                 = var.name
  desired_capacity     = var.desired_capacity
  min_size             = var.min_size
  max_size             = var.max_size
  vpc_zone_identifier  = var.vpc_zone_identifier
  target_group_arns    = var.target_group_arns
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.name
  }
}