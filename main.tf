#########################################
# FINAL COMPARTMENT
#########################################
locals {
  final_compartment_id = var.create_compartment
    ? oci_identity_compartment.comp[0].id
    : var.compartment_id
}

#########################################
# COMPARTMENT
#########################################
resource "oci_identity_compartment" "comp" {
  count = var.create_compartment ? 1 : 0

  name           = var.compartment_name
  description    = "Created via Terraform"
  compartment_id = var.compartment_id
}

#########################################
# NETWORK
#########################################
resource "oci_core_vcn" "vcn" {
  count = var.create_network ? 1 : 0

  cidr_block     = var.vcn_cidr
  compartment_id = local.final_compartment_id
}

resource "oci_core_subnet" "subnet" {
  count = var.create_network ? 1 : 0

  cidr_block     = var.subnet_cidr
  vcn_id         = oci_core_vcn.vcn[0].id
  compartment_id = local.final_compartment_id
}

#########################################
# INSTANCE
#########################################
resource "oci_core_instance" "app" {
  count = var.create_instance ? var.instance_count : 0

  display_name   = "${var.instance_name}-${count.index}"
  compartment_id = local.final_compartment_id

  subnet_id = var.create_network
    ? oci_core_subnet.subnet[0].id
    : var.subnet_id

  shape = "VM.Standard.E2.1.Micro"

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1..." # replace
  }
}

#########################################
# BACKEND IPS
#########################################
locals {
  backend_ips = var.create_instance
    ? [for i in oci_core_instance.app : i.private_ip]
    : split(",", var.existing_instance_ips)
}

#########################################
# LOAD BALANCER
#########################################
resource "oci_load_balancer_load_balancer" "lb" {
  count = var.create_lb ? 1 : 0

  compartment_id = local.final_compartment_id
  display_name   = var.lb_name
  shape          = var.lb_shape

  subnet_ids = [
    var.create_network
    ? oci_core_subnet.subnet[0].id
    : var.subnet_id
  ]

  is_private = var.is_private_lb
}

resource "oci_load_balancer_backend" "backend" {
  count = var.create_lb ? length(local.backend_ips) : 0

  load_balancer_id = oci_load_balancer_load_balancer.lb[0].id
  backendset_name  = "backendset1"

  ip_address = local.backend_ips[count.index]
  port       = 80
}
