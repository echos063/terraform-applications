# Networks creating
module "network_config" {
  env             = var.env
  source          = "./modules/networks"
  backend_network_name    = "${var.env}-app_backend_net"
  backend_bridge_name     = "${var.env}-br-bck"
  backend_domain          = "backend.app.local"
  dmz_network_name        = "${var.env}-app_dmz_net"
  dmz_bridge_name         = "${var.env}-br-dmz"
  dmz_domain              = "dmz.app.local"
  backend_network_address = local.backend_network_address
  dmz_network_address     = local.dmz_network_address
}

# Projects creating
module "applications-stand" {
  env = var.env
  source = "./modules/applications"
  backend_counter = 0
  frontend_counter = 0
  postgres-app_counter = 0
  backend_network_id = module.network_config.backend_network_id
  dmz_network_id = module.network_config.dmz_network_id
}
