# ALB Switcher
resource "aws_lb" "switcher" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets            = data.aws_subnets.public.ids

  tags = {
    Environment = "production"
  }
}

# Target Groups
resource "aws_lb_target_group" "blue" {
  name     = "cmtr-o84gfl9h-blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.existing.id
}

resource "aws_lb_target_group" "green" {
  name     = "cmtr-o84gfl9h-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.existing.id
}

# ALB Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.switcher.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}
