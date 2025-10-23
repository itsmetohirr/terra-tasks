resource "aws_launch_template" "cmtr_o84gfl9h_template" {
  name          = "cmtr-o84gfl9h-template"
  instance_type = "t3.micro"
  key_name      = "cmtr-o84gfl9h-keypair"
  image_id      = "ami-09e6f87a47903347c"

  iam_instance_profile {
    name = "cmtr-o84gfl9h-instance_profile"
  }

  network_interfaces {
    delete_on_termination = true
    security_groups = [
      "cmtr-o84gfl9h-ec2_sg",
      "cmtr-o84gfl9h-http_sg"
    ]
  }

  user_data = filebase64("${path.module}/user_data.sh")

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "cmtr-o84gfl9h-template-instance"
      Terraform = "true"
      Project   = "cmtr-o84gfl9h"
    }
  }

  tags = {
    Terraform = "true"
    Project   = "cmtr-o84gfl9h"
  }
}

resource "aws_autoscaling_group" "cmtr_o84gfl9h_asg" {
  name                = "cmtr-o84gfl9h-asg"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 2
  vpc_zone_identifier = ["public_subnet_cidr_a", "public_subnet_cidr_b"]

  launch_template {
    id      = aws_launch_template.cmtr_o84gfl9h_template.id
    version = "$Latest"
  }

  # Tags applied to launched EC2 instances
  tag {
    key                 = "Name"
    value               = "cmtr-o84gfl9h-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "cmtr-o84gfl9h"
    propagate_at_launch = true
  }

  # Ignore load balancer or target group changes (as required)
  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}

# ============================================================
# Application Load Balancer
# ============================================================
resource "aws_lb" "cmtr_o84gfl9h_loadbalancer" {
  name               = "cmtr-o84gfl9h-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["cmtr-o84gfl9h-sglb"]
  subnets            = ["public_subnet_cidr_a", "public_subnet_cidr_b"]

  enable_deletion_protection = false

  tags = {
    Name      = "cmtr-o84gfl9h-loadbalancer"
    Terraform = "true"
    Project   = "cmtr-o84gfl9h"
  }
}

# ============================================================
# Target Group for ASG instances
# ============================================================
resource "aws_lb_target_group" "cmtr_o84gfl9h_tg" {
  name     = "cmtr-o84gfl9h-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "cmtr-o84gfl9h-vpc"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name      = "cmtr-o84gfl9h-tg"
    Terraform = "true"
    Project   = "cmtr-o84gfl9h"
  }
}

# ============================================================
# Listener for HTTP (port 80)
# ============================================================
resource "aws_lb_listener" "cmtr_o84gfl9h_listener" {
  load_balancer_arn = aws_lb.cmtr_o84gfl9h_loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cmtr_o84gfl9h_tg.arn
  }
}

# ============================================================
# Attach ASG to Target Group
# ============================================================
resource "aws_autoscaling_attachment" "cmtr_o84gfl9h_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.cmtr_o84gfl9h_asg.id
  lb_target_group_arn    = aws_lb_target_group.cmtr_o84gfl9h_tg.arn
}
