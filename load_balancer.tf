resource "oci_load_balancer_load_balancer" "lb" {
  count = var.create_lb ? 1 : 0

  #############################################
  # Compartment (dynamic)
  #############################################
  compartment_id = local.final_compartment_id

  display_name = var.lb_name
  shape        = var.lb_shape

  #############################################
  # Subnet (Create OR Existing)
  #############################################
  subnet_ids = [
    var.create_network
    ? oci_core_subnet.subnet[0].id
    : var.subnet_id
  ]

  #############################################
  # Flexible Shape Support
  #############################################
  dynamic "shape_details" {
    for_each = var.lb_shape == "flexible" ? [1] : []
    content {
      minimum_bandwidth_in_mbps = 10
      maximum_bandwidth_in_mbps = 100
    }
  }

  #############################################
  # Public / Private LB
  #############################################
  is_private = false
}
