variable "allowed_ip_range" {
  description = "list of IP address range for secure access"
  type        = list(string)
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = "vpc-058cc484f4757da3e"
}

variable "public_eni_id" {
  description = "public instance network interface id"
  type        = string
  default     = "eni-0d39d628cf65f2820"
}

variable "private_eni_id" {
  description = "pricate eni id"
  type        = string
  default     = "eni-09edaf921dd59a5f6"
}
