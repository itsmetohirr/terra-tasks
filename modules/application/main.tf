resource "aws_launch_template" "lt" {
  name          = "cmtr-o84gfl9h-template"
  instance_type = var.instance_type
  image_id      = var.image_id

  # Attach SGs through network interface
  network_interfaces {
    security_groups = [
      var.private_http_sg_id
    ]
    delete_on_termination = true
  }

  # Startup script
  user_data = base64encode(<<EOF
#!/bin/bash

# Install Apache
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd

# Collect instance metadata
COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
COMPUTE_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Generate HTML page
cat <<HTML > /var/www/html/index.html
<html>
  <h1>This message was generated on instance $${COMPUTE_INSTANCE_ID}</h1>
  <h2>UUID: $${COMPUTE_MACHINE_UUID}</h2>
</html>
HTML

EOF
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = "cmtr-o84gfl9h-asg"
  vpc_zone_identifier = [var.vpc_id]
  target_group_arns   = [aws_lb_target_group.tg.arn]

  desired_capacity = 2
  min_size         = 2
  max_size         = 2

  health_check_type = "EC2"
  force_delete      = true

  # connect to launch template
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}

resource "aws_lb" "alb" {
  name               = "cmtr-o84gfl9h-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "cmtr-o84gfl9h-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "simple_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_autoscaling_attachment" "asg_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}
