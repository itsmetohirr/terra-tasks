variable "state_bucket" {
  description = "Name of the S3 bucket storing the remote Terraform state"
  type        = string
  default     = "cmtr-o84gfl9h-tf-state-1761138286"
}

variable "state_key" {
  description = "Path/key of the remote state file within the S3 bucket"
  type        = string
  default     = "infra.tfstate"
}

variable "aws_region" {
  description = "AWS region where the S3 bucket is located"
  type        = string
  default     = "us-east-1"
}
