variable "alb_name" {
  description = "alb name"
  type        = string
  default     = "cmtr-o84gfl9h-lb"
}

variable "blue_template_name" {
  description = "blue template name"
  type        = string
  default     = "cmtr-o84gfl9h-blue-template"
}

variable "green_template_name" {
  description = "green template name"
  type        = string
  default     = "cmtr-o84gfl9h-green-template"
}

# Traffic Weight for Blue and Green Target Groups  
variable "blue_weight" {
  description = "The traffic weight for the Blue Target Group. Specifies the percentage of traffic routed to the Blue environment."
  type        = number
  default     = 100
}

variable "green_weight" {
  description = "The traffic weight for the Green Target Group. Specifies the percentage of traffic routed to the Green environment."
  type        = number
  default     = 0
}
