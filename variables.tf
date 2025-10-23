# ============================================================
# General configuration variables
# ============================================================

variable "aws_region" {
  description = "The AWS region where all resources will be created"
  type        = string
}

variable "project_id" {
  description = "The project identifier used for tagging and naming resources"
  type        = string
}

# ============================================================
# Networking discovery variables
# ============================================================

variable "vpc_name" {
  description = "The name of the existing VPC to discover and use"
  type        = string
}

variable "public_subnet_name" {
  description = "The name of the public subnet to discover within the VPC"
  type        = string
}

variable "security_group_name" {
  description = "The name of the existing security group to discover and attach to resources"
  type        = string
}
