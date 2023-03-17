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