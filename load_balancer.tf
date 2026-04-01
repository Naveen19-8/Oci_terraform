#############################################
# LOAD BALANCER
#############################################

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
  # Public / Private
  #############################################
  is_private = var.is_private_lb
}

#############################################
# BACKEND SET
#############################################

resource "oci_load_balancer_backend_set" "backend_set" {
  count            = var.create_lb ? 1 : 0
  name             = "backendset1"
  load_balancer_id = oci_load_balancer_load_balancer.lb[0].id
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol = "HTTP"
    port     = 80
    url_path = "/"
  }
}

#############################################
# BACKENDS (AUTO FROM INSTANCES)
#############################################

resource "oci_load_balancer_backend" "backend" {
  count = var.create_lb ? length(local.backend_ips) : 0

  load_balancer_id = oci_load_balancer_load_balancer.lb[0].id
  backendset_name  = oci_load_balancer_backend_set.backend_set[0].name

  ip_address = local.backend_ips[count.index]
  port       = 80
}

#############################################
# LISTENER
#############################################

resource "oci_load_balancer_listener" "listener" {
  count = var.create_lb ? 1 : 0

  load_balancer_id         = oci_load_balancer_load_balancer.lb[0].id
  name                     = "http_listener"
  default_backend_set_name = oci_load_balancer_backend_set.backend_set[0].name
  port                     = 80
  protocol                 = "HTTP"
}
