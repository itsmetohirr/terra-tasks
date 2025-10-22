terraform {
  required_version = var.tf_version
}

provider "aws" {
  region = "us-east-1"
}
