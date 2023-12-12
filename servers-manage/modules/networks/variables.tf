# Environment variable
variable "env" {
  description = "The environment (dev, stage, prod)"
  type        = string
}

variable "backend_network_name" {
  description = "The name of the network"
}
variable "dmz_network_name" {
  description = "The name of the network"
}
variable "backend_bridge_name" {
  description = "The name of the bridge"
}
variable "dmz_bridge_name" {
  description = "The name of the bridge"
}
variable "backend_domain" {
  description = "The domain name"
}
variable "dmz_domain" {
  description = "The domain name"
}
variable "backend_network_address" {
  description = "The network address"
}
variable "dmz_network_address" {
  description = "The network address"
}