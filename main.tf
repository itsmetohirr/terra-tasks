module "network" {
  source        = "./modules/network"
  vpc_cidr      = "10.10.0.0/16"
  public_1_name = "cmtr-o84gfl9h-subnet-public-a"
  public_1_cidr = "10.10.1.0/24"
  public_2_name = "cmtr-o84gfl9h-subnet-public-b"
  public_2_cidr = "10.10.3.0/24"
  public_3_name = "cmtr-o84gfl9h-subnet-public-c"
  public_3_cidr = "10.10.5.0/24"
  igw_name      = "cmtr-o84gfl9h-igw"
  rt_name       = "cmtr-o84gfl9h-rt"
  aws_region    = "us-east-1"
}

module "network_security" {
  source           = "./modules/network_security"
  vpc_id           = module.network.vpc_id
  allowed_ip_range = var.allowed_ip_range
  ssh_port         = 22
  http_port        = 80
}

module "application" {
  source             = "./modules/application"
  vpc_id             = module.network.vpc_id
  instance_type      = "t3.micro"
  alb_sg_id          = module.network_security.public_http_sg_id
  private_http_sg_id = module.network_security.private_http_sg_id
  subnet_ids         = module.network.subnet_ids
  image_id           = "ami-07860a2d7eb515d9a"
}
