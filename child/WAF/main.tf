resource "aws_wafv2_web_acl" "gogreen_waf" {
  name        = "gogreen_waf"
  scope       = "REGIONAL"
  description = "Example WebACL with SQLi, XSS prevention, IP rate limiting and bot protection."

  default_action {
    allow {}
  }

  rule {
    name     = "SQLiRule"
    priority = 1
    action {
      block {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "SQLiRule"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "XSSRule"
    priority = 2
    action {
      block {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "XSSRule"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "IPRateLimitRule"
    priority = 0
    action {
      block {}
    }
    statement {
      rate_based_statement {
        limit              = var.rate_limit
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "IPRateLimitRule"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "BotProtectionRule"
    priority = 3
    action {
      block {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesBotControlRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "BotProtectionRule"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "example"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_association" "gogreen_waf_association" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.gogreen_waf.arn
}
