

provider "google" {
  project     = "terraform-gcp-example-451603"
  credentials = "./terraform-gcp-example-451603-b478f9b4be8d.json"
  region      = "us-central1"
  zone        = "us-central1-c"
}


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      labels = {
        my_label = "value"
      }
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }



}

output "ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
