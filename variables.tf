variable "create_lb" {
  type    = bool
  default = true
}

variable "lb_name" {
  type = string
}

variable "lb_shape" {
  type    = string
  default = "flexible"
}

variable "compartment_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "backend_ips" {
  type    = list(string)
  default = []
}

variable "existing_lb_id" {
  type    = string
  default = ""
}
