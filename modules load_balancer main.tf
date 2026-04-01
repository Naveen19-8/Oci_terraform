variable "subnet_id" {}
variable "lb_type" {}
variable "backends" {}

resource "oci_load_balancer_load_balancer" "lb" {
  compartment_id = var.subnet_id
  shape = "flexible"

  is_private = var.lb_type == "private"
  subnet_ids = [var.subnet_id]
}