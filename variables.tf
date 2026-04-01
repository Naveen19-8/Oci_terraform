variable "prefix" {}
variable "region" {}

variable "create_compartment" { type = bool }
variable "existing_compartment_id" {}

variable "create_vcn" { type = bool }
variable "separate_subnets" { type = bool }

variable "deploy_app" { type = bool }
variable "app_count" { default = 2 }
variable "app_shape" {}

variable "deploy_db" { type = bool }
variable "db_count" { default = 1 }
variable "db_shape" {}

variable "deploy_lb" { type = bool }
variable "lb_type" {}
variable "auto_attach_lb" { type = bool }

variable "ssh_public_key" {}
variable "image_id" { default = "" }