data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-o84gfl9h-vpc"]
  }
}

data "aws_subnets" "public" {
  filter {
    name = "tag:Name"
    values = [
      "cmtr-o84gfl9h-public-subnet1",
      "cmtr-o84gfl9h-public-subnet2"
    ]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "group-name"
    values = ["cmtr-o84gfl9h-sg-ssh"]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = ["cmtr-o84gfl9h-sg-http"]
  }
}

data "aws_security_group" "lb" {
  filter {
    name   = "group-name"
    values = ["cmtr-o84gfl9h-sg-lb"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
