resource "aws_launch_template" "go_green_tmp" {
  name = "${var.template_name}-tier-template"

  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  user_data = base64encode(file("${path.module}/userdata/userdata.sh")) 

  network_interfaces {
    associate_public_ip_address = false
    security_groups = var.security_group_ids
  }

  tags = {
    Name = "${var.tag_name}-tier-template"
  }
}
