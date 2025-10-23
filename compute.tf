# ============================================================
# EC2 Instance Configuration
# ============================================================

resource "aws_instance" "cmtr_o84gfl9h_instance" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [data.aws_security_group.selected.id]
  associate_public_ip_address = true

  tags = {
    Name      = "cmtr-o84gfl9h-instance"
    Terraform = "true"
    Project   = var.project_id
  }
}
