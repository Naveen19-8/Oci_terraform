variable "create_vcn" {}
variable "compartment_id" {}
variable "prefix" {}
variable "separate_subnets" {}

resource "oci_core_vcn" "vcn" {
  count = var.create_vcn ? 1 : 0
  cidr_block = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name = "${var.prefix}-vcn"
}

resource "oci_core_subnet" "app" {
  cidr_block = "10.0.1.0/24"
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn[0].id
}

resource "oci_core_subnet" "db" {
  count = var.separate_subnets ? 1 : 0
  cidr_block = "10.0.2.0/24"
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn[0].id
}

output "app_subnet_id" {
  value = oci_core_subnet.app.id
}

output "db_subnet_id" {
  value = var.separate_subnets ? oci_core_subnet.db[0].id : oci_core_subnet.app.id
}