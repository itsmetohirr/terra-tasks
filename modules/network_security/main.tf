resource "aws_security_group" "ssh" {
  name        = "cmtr-o84gfl9h-ssh-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id
  ingress {
    description = "SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public_http" {
  name        = "cmtr-o84gfl9h-public-http-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id
  ingress {
    description = "HTTP"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_http" {
  name        = "cmtr-o84gfl9h-private-http-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id
  ingress {
    description = "SSH"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    security_groups = [ aws_security_group.public_http.id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
