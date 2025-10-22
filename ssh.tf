resource "aws_key_pair" "default" {
  key_name   = "cmtr-o84gfl9h-keypair"
  public_key = var.ssh_key

  tags = {
    Project = "epam-tf-lab",
    ID      = "cmtr-o84gfl9h"
  }
}
