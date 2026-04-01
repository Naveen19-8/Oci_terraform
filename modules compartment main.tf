variable "create" {}
variable "name" {}
variable "existing_id" {}

resource "oci_identity_compartment" "compartment" {
  count = var.create ? 1 : 0
  name = var.name
  description = "Created by Terraform"
  compartment_id = var.existing_id
}

output "compartment_id" {
  value = var.create ? oci_identity_compartment.compartment[0].id : var.existing_id
}

