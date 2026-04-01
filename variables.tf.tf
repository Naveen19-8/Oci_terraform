variable "create_lb" {
  description = "Create a new Load Balancer?"
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
  description = "Backend Server IPs"
  type        = list(string)
  default     = []
}

variable "existing_lb_id" {
  description = "Existing Load Balancer OCID (used if create_lb = false)"
  type        = string
  default     = ""
}