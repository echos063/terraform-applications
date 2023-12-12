# Environment variable
variable "env" {
  description = "The environment (dev, stage, prod)"
  type        = string
  default     = "dev"
}

# Network backend
locals {
  backend_subnet_map = {
    dev   = "10.9.110.0/24"
    stage = "10.10.110.0/24"
    prod  = "10.15.110.0/24"
  }

 dmz_subnet_map = {
    dev   = "10.9.220.0/24"
    stage = "10.10.220.0/24"
    prod  = "10.15.220.0/24"
  }

  backend_network_address = local.backend_subnet_map[var.env]
  dmz_network_address = local.dmz_subnet_map[var.env]
}
