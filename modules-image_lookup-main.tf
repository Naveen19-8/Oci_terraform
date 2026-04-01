variable "compartment_id" {}

data "oci_core_images" "images" {
  compartment_id = var.compartment_id
  operating_system = "Oracle Linux"
}

output "image_id" {
  value = data.oci_core_images.images.images[0].id
}