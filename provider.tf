#########################################
# OCI PROVIDER
#########################################

provider "oci" {
  region = var.region
}

#########################################
# VARIABLES
#########################################

variable "region" {
  description = "OCI Region"
  type        = string
  default     = "ap-mumbai-1"
}
