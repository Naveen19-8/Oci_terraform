output "lb_id" {
  value = try(oci_load_balancer_load_balancer.lb[0].id, null)
}

output "lb_name" {
  value = var.lb_name
}
