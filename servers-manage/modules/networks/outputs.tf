output "backend_network_id" {
  value = libvirt_network.backend_app_network.id
}

output "dmz_network_id" {
  value = libvirt_network.dmz_app_network.id
}

output "backend_network_address" {
  value = libvirt_network.backend_app_network.addresses[0]
}

output "dmz_network_address" {
  value = libvirt_network.dmz_app_network.addresses[0]
}
