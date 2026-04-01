variable "create_lb" {
  description = "Create new Load Balancer"
  type        = bool
  default     = true
}

variable "lb_name" {
  description = "Load Balancer Name"
  type        = string
}

variable "lb_shape" {
  description = "Load Balancer Shape"
  type        = string
  default     = "flexible"
}

variable "compartment_id" {
  description = "Compartment OCID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet OCID"
  type        = string
}

variable "backend_ips" {
  type = string
}

variable "existing_lb_id" {
  description = "Existing Load Balancer OCID"
  type        = string
  default     = ""
}
variable "tenancy_ocid" {
  type = string
}
