terraform {
    backend "http" {}
}

provider "google" {
    credentials = <<EOT
        SERVICE_ACCOUNT_KEY_FILE_CONTENTS
    EOT
}

resource "google_compute_instance" "default" {
  project = var.project_id
  name         = "direktiv-test-machine"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["direktiv", "vorteil"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }


}

variable "project_id" {
  description = "project_id to spawn the virtual machine on"
}


output "ip-address" {
    value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}

