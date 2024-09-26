provider "google" {
  project     = var.project
  region      = var.region
}

resource "google_compute_instance" "bibit-compute-instance" {
  count          = var.count_compute
  name           = format("vm-%s-%s-%d", var.instance_name_header, var.compute_name, count.index + var.count_start)
  machine_type   = var.compute_type
  zone           = element(var.compute_zones, count.index)
  can_ip_forward = var.ip_forward

  boot_disk {
    initialize_params {
      image = var.images_name
      size  = var.size_root_disk
      type  = var.type_root_disk
    }
  }

  network_interface {
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    
    access_config {
      network_tier = "STANDARD"
    }
  }

  tags = ["${var.instance_name_header}-${var.compute_name}", "terraform"]

  allow_stopping_for_update = true

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = "true"
  }
}