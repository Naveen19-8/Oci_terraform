#############################################
# BASIC CONFIGURATION
#############################################

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

#############################################
# NETWORK CONFIGURATION
#############################################

variable "compartment_id" {
  description = "Compartment OCID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet OCID"
  type        = string
}

#############################################
# BACKEND CONFIGURATION (DROPDOWN SINGLE)
#############################################

variable "backend_ips" {
  description = "Backend IP (selected from dropdown)"
  type        = string
}

#############################################
# EXISTING LOAD BALANCER (OPTIONAL)
#############################################

variable "existing_lb_id" {
  description = "Existing Load Balancer OCID"
  type        = string
  default     = ""
}

#############################################
# OPTIONAL PROVIDER SETTINGS
#############################################

variable "region" {
  description = "OCI Region"
  type        = string
  default     = "ap-mumbai-1"
}

variable "compartment_name" {
  description = "New Compartment Name"
  type        = string
}

variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}
variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
  default     = ""
}
