resource "oci_load_balancer_load_balancer" "lb" {
  count = var.create_lb ? 1 : 0

  compartment_id = var.compartment_id
  display_name   = var.lb_name
  shape          = var.lb_shape

  subnet_ids = [var.subnet_id]

  #############################################
  # Optional: Flexible Shape Support
  #############################################
  dynamic "shape_details" {
    for_each = var.lb_shape == "flexible" ? [1] : []
    content {
      minimum_bandwidth_in_mbps = 10
      maximum_bandwidth_in_mbps = 100
    }
  }

  #############################################
  # Optional: Public / Private LB
  #############################################
  is_private = false
}
