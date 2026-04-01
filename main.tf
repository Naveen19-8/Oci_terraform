module "compartment" {
  source = "./modules/compartment"
  create = var.create_compartment
  name   = "${var.prefix}-cmp"
  existing_id = var.existing_compartment_id
}

module "network" {
  source = "./modules/network"
  create_vcn = var.create_vcn
  separate_subnets = var.separate_subnets
  compartment_id = module.compartment.compartment_id
  prefix = var.prefix
}

module "image" {
  source = "./modules/image_lookup"
  compartment_id = module.compartment.compartment_id
}

module "app" {
  source = "./modules/compute_app"
  count  = var.deploy_app ? 1 : 0

  instance_count = var.app_count
  compartment_id = module.compartment.compartment_id
  subnet_id      = module.network.app_subnet_id
  shape          = var.app_shape
  ssh_key        = var.ssh_public_key
  image_id       = var.image_id != "" ? var.image_id : module.image.image_id
  prefix         = var.prefix
}

module "db" {
  source = "./modules/compute_db"
  count  = var.deploy_db ? 1 : 0

  instance_count = var.db_count
  compartment_id = module.compartment.compartment_id
  subnet_id      = var.separate_subnets ? module.network.db_subnet_id : module.network.app_subnet_id
  shape          = var.db_shape
  ssh_key        = var.ssh_public_key
  image_id       = module.image.image_id
  prefix         = var.prefix
}

module "lb" {
  source = "./modules/load_balancer"
  count  = var.deploy_lb ? 1 : 0

  subnet_id = module.network.app_subnet_id
  lb_type   = var.lb_type
  backends  = var.auto_attach_lb && var.deploy_app ? module.app[0].private_ips : []
}