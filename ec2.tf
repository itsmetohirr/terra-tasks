resource "aws_instance" "example" {
  ami                    = "ami-0341d95f75f311023"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["cmtr-o84gfl9h-sg"]
  key_name               = aws_key_pair.default.key_name
  associate_public_ip_address = true

  tags = {
    Project = "epam-tf-lab",
    ID      = "cmtr-o84gfl9h"
  }
}
