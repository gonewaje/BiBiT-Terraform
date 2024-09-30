
terraform {
  # required_version = "~> 0.14"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }

  backend "gcs" {
    bucket = "silent-complex-436709-b9-terraform"
    prefix = "state/vm/java"
  }
}

module "default" {
  source = "../../modules/public-ip/"

  project              = "silent-complex-436709-b9"
  count_start          = 1
  count_compute        = 1
  instance_name_header = "java"
  compute_name         = "bibit"
  compute_type         = "t2d-standard-1"
  ip_forward           = false
  images_name          = "ubuntu-2004-focal-v20240830"
  size_root_disk       = 30
  type_root_disk       = "pd-standard"

  region               = "asia-southeast1"
  compute_zones        = ["asia-southeast1-a", "asia-southeast1-b", "asia-southeast1-c"]
  subnetwork           = "default"
  subnetwork_project   = "silent-complex-436709-b9"
  additional_tags      = "http-server"
}
