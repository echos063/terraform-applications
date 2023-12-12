resource "libvirt_network" "backend_app_network" {
  name      = var.backend_network_name
  autostart = true
  mode      = "nat"
  bridge    = var.backend_bridge_name
  domain    = var.backend_domain
  addresses = [var.backend_network_address]
  dns {
    enabled = true
    local_only = true
  }
}

resource "libvirt_network" "dmz_app_network" {
  name      = var.dmz_network_name
  autostart = true
  mode      = "nat"
  bridge    = var.dmz_bridge_name
  domain    = var.dmz_domain
  addresses = [var.dmz_network_address]
  dns {
    enabled = true
    local_only = true
  }
}