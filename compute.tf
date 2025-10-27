# Blue Launch Template
resource "aws_launch_template" "blue_lt" {
  name        = var.blue_template_name
  description = "Blue EC2 launch template"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    data.aws_security_group.ssh.id,
    data.aws_security_group.http.id
  ]

  network_interfaces {
    associate_public_ip_address = true
  }

  user_data = filebase64("${path.module}/start-blue.sh")
}

# Green Launch Template
resource "aws_launch_template" "green_lt" {
  name        = var.green_template_name
  description = "Green EC2 launch template"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      data.aws_security_group.ssh.id,
      data.aws_security_group.http.id
    ]
  }

  user_data = filebase64("${path.module}/start-green.sh")
}

# Blue Auto Scaling Group
resource "aws_autoscaling_group" "blue" {
  name                      = "cmtr-o84gfl9h-blue-asg"
  vpc_zone_identifier       = data.aws_subnets.public.ids
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 4
  target_group_arns         = [aws_lb_target_group.blue.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 30

  launch_template {
    id      = aws_launch_template.blue_lt.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Green Auto Scaling Group
resource "aws_autoscaling_group" "green" {
  name                      = "cmtr-o84gfl9h-green-asg"
  vpc_zone_identifier       = data.aws_subnets.public.ids
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 4
  target_group_arns         = [aws_lb_target_group.green.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 30

  launch_template {
    id      = aws_launch_template.green_lt.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}
