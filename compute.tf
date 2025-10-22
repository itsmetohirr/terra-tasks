resource "aws_instance" "public_instance" {
  ami           = "ami-0341d95f75f311023"
  instance_type = "t3.micro"

  subnet_id              = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Name      = "cmtr-o84gfl9h-public-instance"
    Terraform = "true"
    Project   = "cmtr-o84gfl9h"
  }
}
