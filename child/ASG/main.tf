resource "aws_autoscaling_group" "go_green" {
  name                 = "ASG-${var.asg_name}-tier"
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
    value               = "${var.asg_tag}-tier"
    propagate_at_launch = true 
  }
}