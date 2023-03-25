resource "aws_launch_template" "go_green_tmp" {
  name = "${var.template_name}-tier-template"

  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  user_data = base64encode(file("${path.module}/userdata/userdata")) 

  tags = {
    Name = "${var.tag_name}-tier-template"
  }
}
