#############################################
# OUTPUTS
#############################################

output "load_balancer_id" {
  description = "Load Balancer OCID"
  value       = try(oci_load_balancer_load_balancer.lb[0].id, null)
}

output "load_balancer_name" {
  description = "Load Balancer Name"
  value       = var.lb_name
}

output "backend_ip" {
  description = "Selected Backend IP"
  value       = var.backend_ips
}
