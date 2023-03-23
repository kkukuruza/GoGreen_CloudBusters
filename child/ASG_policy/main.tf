resource "aws_cloudwatch_metric_alarm" "high_bandwidth_alarm" {
  alarm_name          = "HighNetworkBandwidthAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AverageNetworkBandwidth"
  namespace           = "GoGreenSpace"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "750"
  alarm_description   = "This metric checks if the average network bandwidth is greater than or equal to 750 Mbps"
  alarm_actions       = [aws_autoscaling_policy.scale_up_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "low_bandwidth_alarm" {
  alarm_name          = "LowNetworkBandwidthAlarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AverageNetworkBandwidth"
  namespace           = "GoGreenSpace"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "300"
  alarm_description   = "This metric checks if the average network bandwidth is less than or equal to 300 Mbps"
  alarm_actions       = [aws_autoscaling_policy.scale_down_policy.arn]
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "ScaleUpPolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "ScaleDownPolicy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.asg_name
}
