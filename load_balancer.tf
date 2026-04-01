#############################################
# COMPARTMENT
#############################################

output "compartment_id" {
  description = "Final Compartment OCID"
  value       = local.final_compartment_id
}

#############################################
# NETWORK
#############################################

output "vcn_id" {
  value = try(oci_core_vcn.vcn[0].id, var.vcn_id)
}

output "subnet_id" {
  value = try(oci_core_subnet.subnet[0].id, var.subnet_id)
}

#############################################
# INSTANCE
#############################################

output "instance_private_ips" {
  description = "Instance Private IPs"
  value       = local.backend_ips
}

#############################################
# LOAD BALANCER
#############################################

output "load_balancer_id" {
  description = "Load Balancer OCID"
  value       = try(oci_load_balancer_load_balancer.lb[0].id, null)
}

output "load_balancer_name" {
  value = var.lb_name
}
