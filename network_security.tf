

resource "aws_security_group" "allow_ssh" {
  name        = "cmtr-o84gfl9h-ssh-sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "Allow ICMP (all types)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_http" {
  name        = "cmtr-o84gfl9h-public-http-sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "Allow ICMP (all types)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_private_http" {
  name        = "cmtr-o84gfl9h-private-http-sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_http]
  }

  ingress {
    description     = "Allow ICMP (all types)"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.allow_http]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface_sg_attachment" "ssh_attach" {
  security_group_id    = aws_security_group.allow_ssh.id
  network_interface_id = var.public_eni_id
}

resource "aws_network_interface_sg_attachment" "http_attach" {
  security_group_id    = aws_security_group.allow_http.id
  network_interface_id = var.public_eni_id
}

resource "aws_network_interface_sg_attachment" "ssh_attach_private" {
  security_group_id    = aws_security_group.allow_ssh.id
  network_interface_id = var.private_eni_id
}

resource "aws_network_interface_sg_attachment" "http_attach_private" {
  security_group_id    = aws_security_group.allow_private_http.id
  network_interface_id = var.private_eni_id
}
