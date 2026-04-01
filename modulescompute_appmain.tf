variable "instance_count" {}
variable "compartment_id" {}
variable "subnet_id" {}
variable "shape" {}
variable "ssh_key" {}
variable "image_id" {}
variable "prefix" {}

resource "oci_core_instance" "app" {
  count = var.instance_count

  display_name = "${var.prefix}-app-${count.index}"
  compartment_id = var.compartment_id
  shape = var.shape

  create_vnic_details {
    subnet_id = var.subnet_id
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_key
  }
}

output "private_ips" {
  value = oci_core_instance.app[*].private_ip
}

