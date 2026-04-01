resource "oci_load_balancer_load_balancer" "lb" {
  count          = var.create_lb ? 1 : 0
  compartment_id = var.compartment_id
  display_name   = var.lb_name
  shape          = var.lb_shape

  subnet_ids = [var.subnet_id]
}
