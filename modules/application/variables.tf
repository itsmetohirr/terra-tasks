variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "image_id" {
  description = "image id"
  type = string
}

variable "instance_type" {
  description = "intance type"
  type = string
}

variable "alb_sg_id" {
  description = "sg ids"
  type = string
}

variable "subnet_ids" {
  description = "subnet ids"
  type = list(string)
}

variable "private_http_sg_id" {
  description = "sg id"
  type = string
}
