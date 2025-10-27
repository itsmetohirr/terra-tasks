variable "aws_region" {
  description = "region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "vpc cird"
  type        = string
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
}

variable "public_1_name" {
  description = "cmtr-o84gfl9h-subnet-public-a "
  type        = string
}

variable "public_2_name" {
  description = "cmtr-o84gfl9h-subnet-public-b "
  type        = string
}

variable "public_3_name" {
  description = "cmtr-o84gfl9h-subnet-public-c "
  type        = string
}

variable "igw_name" {
  description = "cmtr-o84gfl9h-igw"
  type        = string
}

variable "rt_name" {
  description = "cmtr-o84gfl9h-rt"
  type        = string
}

variable "public_1_cidr" {
  description = "public 1 cidr"
  type        = string
}

variable "public_2_cidr" {
  description = "public 2 cidr"
  type        = string
}

variable "public_3_cidr" {
  description = "public 3 cidr"
  type        = string
}
