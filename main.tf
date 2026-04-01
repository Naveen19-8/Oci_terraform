#############################################
# OCI Load Balancer - Main Entry
#############################################

locals {
  create_lb = var.create_lb
}

#############################################
# Create Load Balancer (only if enabled)
#############################################

resource "oci_load_balancer_load_balancer" "lb" {
  count = local.create_lb ? 1 : 0

  compartment_id = var.compartment_id
  display_name   = var.lb_name
  shape          = var.lb_shape

  subnet_ids = [var.subnet_id]

  # Optional (recommended for flexible shape)
  dynamic "shape_details" {
    for_each = var.lb_shape == "flexible" ? [1] : []
    content {
      minimum_bandwidth_in_mbps = 10
      maximum_bandwidth_in_mbps = 100
    }
  }
}

#############################################
# Backend Set (only if LB created)
#############################################

resource "oci_load_balancer_backend_set" "backend_set" {
  count            = local.create_lb ? 1 : 0
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
# Backends (loop through IPs)
#############################################

resource "oci_load_balancer_backend" "backend" {
  count = local.create_lb ? length(var.backend_ips) : 0

  load_balancer_id = oci_load_balancer_load_balancer.lb[0].id
  backendset_name  = oci_load_balancer_backend_set.backend_set[0].name

  ip_address = var.backend_ips[count.index]
  port       = 80
}

#############################################
# Listener
#############################################

resource "oci_load_balancer_listener" "listener" {
  count = local.create_lb ? 1 : 0

  load_balancer_id         = oci_load_balancer_load_balancer.lb[0].id
  name                     = "http_listener"
  default_backend_set_name = oci_load_balancer_backend_set.backend_set[0].name
  port                     = 80
  protocol                 = "HTTP"
}
