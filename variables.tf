variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
  default     = "10.10.0.0/16"
}

variable "tf_version" {
  description = "tf version"
  type = string
  default = ">= 1.5.7"
}
