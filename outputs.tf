output "compartment_id" {
  value = local.final_compartment_id
}

output "backend_ips" {
  value = local.backend_ips
}

output "lb_id" {
  value = try(oci_load_balancer_load_balancer.lb[0].id, null)
}
