# Environment variable
variable "env" {
  description = "The environment (dev, stage, prod)"
  type        = string
}

# counterer
variable "backend_counter" {
  description = "The number of servers for backend"
  type        = number
}
variable "frontend_counter" {
  description = "The number of servers for frontend"
  type        = number
}
variable "postgres-app_counter" {
  description = "The number of servers for Postgres"
  type        = number
}

# Network
variable "backend_network_id" {
  description = "The ID of the network to connect to."
  type        = string
  default     = "dev"
}
variable "dmz_network_id" {
  description = "The ID of the network to connect to."
  type        = string
}

locals {
  backend_ips = {
    dev = "10.9.110.11"
    stage = "10.10.110.11"
    prod = "10.15.110.11"
  }
  backend_macs = {
    dev = "52:54:00:e2:09:e6"
    stage = "52:54:00:c2:10:c6"
    prod = "52:54:00:d2:15:d6"
  }

  frontend-backend_ips = {
    dev = "10.9.110.10"
    stage = "10.10.110.10"
    prod = "10.15.110.10"
  }
  frontend-dmz_ips = {
    dev = "10.9.220.5"
    stage = "10.10.220.5"
    prod = "10.15.220.5"
  }
  frontend-backend_macs = {
    dev = "52:54:00:fc:09:c9"
    stage = "52:54:00:fd:10:c0"
    prod = "52:54:00:ff:15:c5"
  }
  frontend-dmz_macs = {
    dev = "52:54:00:dc:09:c9"
    stage = "52:54:00:dd:10:c0"
    prod = "52:54:00:df:15:c5"
  }

  postgres-app_ips = {
    dev = "10.9.110.14"
    stage = "10.10.110.14"
    prod = "10.15.110.14"
  }
  postgres-app_macs = {
    dev = "52:54:00:f5:09:14"
    stage = "52:54:00:c6:10:14"
    prod = "52:54:00:d7:15:14"
  }
}
