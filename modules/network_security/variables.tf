variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "allowed_ip_range" {
  description = "allowed_ip_range"
  type        = list(string)
}

variable "ssh_port" {
  description = "ssh port"
  type        = number
}

variable "http_port" {
  description = "http port"
  type        = number
}
