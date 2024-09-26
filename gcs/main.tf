provider "google" {
  project     = "silent-complex-436709-b9"
  region      = "asia-southeast1"
}

resource "google_storage_bucket" "terraform_state" {
  name     = "silent-complex-436709-b9-terraform"
  location = "ASIA"
  
  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }
}