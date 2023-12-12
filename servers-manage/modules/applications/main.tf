data "template_file" "user_data_backend" {
  template       = file("./modules/applications/cloud-init/backend/user-data.yml")
}
data "template_file" "user_data_frontend" {
  template       = file("./modules/applications/cloud-init/frontend/user-data.yml")
}
data "template_file" "user_data_postgres-app" {
  template       = file("./modules/applications/cloud-init/postgres/user-data.yml")
}

resource "libvirt_cloudinit_disk" "cloudinit_backend" {
  count          = var.backend_counter
  name           = "${var.env}-backend${count.index}.iso"
  user_data      =  data.template_file.user_data_backend.rendered
  pool           = "default"
}
resource "libvirt_cloudinit_disk" "cloudinit_frontend" {
  count          = var.frontend_counter
  name           = "${var.env}-frontend${count.index}.iso"
  user_data      =  data.template_file.user_data_frontend.rendered
  pool           = "default"
}
resource "libvirt_cloudinit_disk" "cloudinit_postgres-app" {
  count          = var.postgres-app_counter
  name           = "${var.env}-postgres-app${count.index}.iso"
  user_data      =  data.template_file.user_data_postgres-app.rendered
  pool           = "default"
}

resource "libvirt_volume" "backend-volume" {
  count          = var.backend_counter
  name           = "${var.env}-backend${count.index}-volume"
  pool           = "default"
  source         = "/pools/lib/os-image.qcow2"
  format         = "qcow2"
}
resource "libvirt_volume" "frontend-volume" {
  count          = var.frontend_counter
  name           = "${var.env}-frontend${count.index}-volume"
  pool           = "default"
  source         = "/pools/lib/os-image.qcow2"
  format         = "qcow2"
}
resource "libvirt_volume" "postgres-app-volume" {
  count          = var.postgres-app_counter
  name           = "${var.env}-postgres-app${count.index}-volume"
  pool           = "default"
  source         = "/pools/lib/os-image.qcow2"
  format         = "qcow2"
}
resource "libvirt_volume" "postgres-app-data-volume" {
  name           = "${var.env}-postgres-app-data-volume"
  pool           = "default"
  source         = "/pools/lib/postgres-external.qcow2"
  format         = "qcow2"
}

resource "libvirt_domain" "backend" {
  count          = var.backend_counter
  name           = "${var.env}-backend${count.index}"
  memory         = "2048"
  vcpu           = 1

  cloudinit      = libvirt_cloudinit_disk.cloudinit_backend[count.index].id

  network_interface {
    network_id   = var.backend_network_id
    hostname     = "${var.env}-backend${count.index}"
    addresses    = [local.backend_ips[var.env]]
    mac          = local.backend_macs[var.env]
    wait_for_lease = true
  }

  disk {
    volume_id    = "${libvirt_volume.backend-volume[count.index].id}"
  }
  boot_device {
    dev          = [ "hd" ]
  }
  console {
    type = "pty"
    target_type  = "serial"
    target_port  = "0"
  }
  graphics {
    type         = "vnc"
    listen_type  = "address"
    autoport     = true
  }
  timeouts {
    create       = "5m"
  }
}

resource "libvirt_domain" "frontend" {
  count          = var.frontend_counter
  name           = "${var.env}-frontend${count.index}"
  memory         = "2048"
  vcpu           = 1

  cloudinit      = libvirt_cloudinit_disk.cloudinit_frontend[count.index].id

  network_interface {
    network_id   = var.backend_network_id
    hostname     = "${var.env}-frontend${count.index}"
    addresses    = [local.frontend-backend_ips[var.env]]
    mac          = local.frontend-backend_macs[var.env]
    wait_for_lease = true
  }
  network_interface {
    network_id   = var.backend_network_id
    hostname     = "${var.env}-frontend${count.index}"
    addresses    = [local.frontend-dmz_ips[var.env]]
    mac          = local.frontend-dmz_macs[var.env]
    wait_for_lease = true
  }

  disk {
    volume_id    = "${libvirt_volume.frontend-volume[count.index].id}"
  }
  boot_device {
    dev          = [ "hd" ]
  }
  console {
    type = "pty"
    target_type  = "serial"
    target_port  = "0"
  }
  graphics {
    type         = "vnc"
    listen_type  = "address"
    autoport     = true
  }
  timeouts {
    create       = "5m"
  }
}

resource "libvirt_domain" "postgres-app" {
  count          = var.postgres-app_counter
  name           = "${var.env}-postgres-app${count.index}"
  memory         = "2048"
  vcpu           = 1

  cloudinit      = libvirt_cloudinit_disk.cloudinit_postgres-app[count.index].id

  network_interface {
    network_id   = var.backend_network_id
    hostname     = "${var.env}-postgres-app${count.index}"
    addresses    = [local.postgres-app_ips[var.env]]
    mac          = local.postgres-app_macs[var.env]
    wait_for_lease = true
  }

  disk {
    volume_id    = "${libvirt_volume.postgres-app-volume[count.index].id}"
  }
  disk {
    volume_id    = "${libvirt_volume.postgres-app-data-volume.id}"
  }

  boot_device {
    dev          = [ "hd" ]
  }
  console {
    type = "pty"
    target_type  = "serial"
    target_port  = "0"
  }
  graphics {
    type         = "vnc"
    listen_type  = "address"
    autoport     = true
  }
  timeouts {
    create       = "5m"
  }
}
