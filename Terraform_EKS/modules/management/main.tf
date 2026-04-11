resource "aws_launch_template" "management" {
  name_prefix   = "mgmt-template-"
  image_id      = var.ami_id
  instance_type = "t3.micro"

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.management_sg_id]
  }

  user_data = base64encode(var.user_data_script)
}

resource "aws_autoscaling_group" "management" {
  name                = "mgmt-asg"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.management.id
    version = "$Latest"
  }
}