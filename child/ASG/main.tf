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


resource "aws_autoscaling_policy" "cpu_utilization" {
  name                   = "cpu-utilization-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.go_green.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}

/*
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.go_green.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "cpu_load_high" {
  alarm_name          = "cpu-load-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "80"
  alarm_description   = "This metric checks for high CPU load"
  alarm_actions       = [aws_autoscaling_policy.scale_out.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.go_green.name
  }
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in-policy"
  autoscaling_group_name = aws_autoscaling_group.go_green.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "cpu_load_low" {
  alarm_name          = "cpu-load-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "30"
  alarm_description   = "This metric checks for low CPU load"
  alarm_actions       = [aws_autoscaling_policy.scale_in.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.go_green.name
  }
}

resource "aws_cloudwatch_metric_alarm" "high_bandwidth_alarm" {
  count               = var.enable_bandwidth_scaling ? 1 : 0
  alarm_name          = "HighNetworkBandwidthAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AverageNetworkBandwidth"
  namespace           = "GoGreenSpace"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "750"
  alarm_description   = "This metric checks if the average network bandwidth is greater than or equal to 750 Mbps"
  alarm_actions       = aws_autoscaling_policy.scale_down_policy.*.arn
}

resource "aws_cloudwatch_metric_alarm" "low_bandwidth_alarm" {
  count               = var.enable_bandwidth_scaling ? 1 : 0
  alarm_name          = "LowNetworkBandwidthAlarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AverageNetworkBandwidth"
  namespace           = "GoGreenSpace"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "300"
  alarm_description   = "This metric checks if the average network bandwidth is less than or equal to 300 Mbps"
  alarm_actions       = aws_autoscaling_policy.scale_up_policy.*.arn
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  count               = var.enable_bandwidth_scaling ? 1 : 0
  name                   = "ScaleUpPolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.go_green.name
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  count               = var.enable_bandwidth_scaling ? 1 : 0
  name                   = "ScaleDownPolicy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.go_green.name
}
*/