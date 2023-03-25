resource "aws_cloudwatch_log_group" "http_errors_log_group" {
  name = var.log_group_name
}

resource "aws_cloudwatch_log_metric_filter" "http_400_errors" {
  name           = "HTTP/400 Errors"
  pattern        = "{ $.httpResponseCode = 400 }"
  log_group_name = aws_cloudwatch_log_group.http_errors_log_group.name

  metric_transformation {
    name      = var.metric_name
    namespace = var.metric_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "http_400_error_rate" {
  alarm_name          = "HTTP/400 Error Rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = var.metric_name
  namespace           = var.metric_namespace
  period              = 60
  statistic           = "SampleCount"
  threshold           = var.error_threshold
  alarm_description   = var.alarm_description
  alarm_actions       = [var.sns_topic]

  dimensions = {
    LogGroupName = aws_cloudwatch_log_group.http_errors_log_group.name
  }
}
