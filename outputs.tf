output "app_ips" {
  value = module.app[*].private_ips
}

output "db_ips" {
  value = module.db[*].private_ips
}