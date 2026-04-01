variable "create_compartment" { type = bool }
variable "compartment_name" { type = string }
variable "compartment_id" { type = string }

variable "create_network" { type = bool }
variable "vcn_cidr" { type = string }
variable "subnet_cidr" { type = string }
variable "vcn_id" { type = string }
variable "subnet_id" { type = string }

variable "create_instance" { type = bool }
variable "instance_name" { type = string }
variable "instance_count" { type = number }
variable "existing_instance_ips" { type = string }

variable "create_lb" { type = bool }
variable "lb_name" { type = string }
variable "lb_shape" { type = string }
variable "is_private_lb" {
  type    = bool
  default = false
}
