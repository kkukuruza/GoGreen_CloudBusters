resource "aws_cloudtrail" "gogreen_cloudtrail" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.bucket
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = var.enable_log_file_validation

  depends_on = [aws_s3_bucket_policy.cloudtrail_bucket_policy]
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail_bucket_lifecycle" {

  rule {
    id = "CloudTrail Rule"
    status = "Enabled"

    transition {
      days          = var.transition_days
      storage_class = "GLACIER"
    }
  }

  bucket = aws_s3_bucket.cloudtrail_bucket.id
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:GetBucketAcl"
        Effect = "Allow"
        Resource = aws_s3_bucket.cloudtrail_bucket.arn
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      },
      {
        Action = "s3:PutObject"
        Effect = "Allow"
        Resource = "${aws_s3_bucket.cloudtrail_bucket.arn}/*"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
} 

# CODE FROM JAS

#Code for Web Tier

module "web" {
  source = "./modules/web"

  instance_type            = ""
  iam_instance_profile_arn = ""

  # load balancer and target groups
  create_load_balancer = true
  target_group_arns    = [
    
  ]
  
  # auto-scaling group
  create_auto_scaling_group = true
  min_size                  = ""
  max_size                  = ""
  desired_capacity          = ""
}

# app tier resources
module "app" {
  source = ""

  instance_type            = ""
  iam_instance_profile_arn = ""

  # load balancer and target groups
  create_load_balancer = true
  target_group_arns    = [
    
  ]
  
  #auto-scaling group
  create_auto_scaling_group = true
  min_size                  = ""
  max_size                  = ""
  desired_capacity          = ""
}

#

# Define the EC2 instance resource
resource "aws_instance" "web" {
  ami           = ""
  instance_type = var.instance_type

  iam_instance_profile = ""

  # Add tags to the instance
  tags = {
    Name = ""
  }
}

# Define the load balancer and target groups
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
  
  ]

  # Define the listener
  listener {
    port = ""

    default_action {
      target_group_arn = ""
      type             = ""
    }
  }
}

resource "aws_lb_target_group" "target_group_1" {
  name_prefix       = ""
  port              = ""
  protocol          = ""
  vpc_id            = ""
  health_check_path = ""
  
  target_type = ""
  
  depends_on = []
}

resource "" "" {
  name_prefix       = ""
}