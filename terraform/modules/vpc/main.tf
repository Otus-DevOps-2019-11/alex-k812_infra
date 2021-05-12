resource "google_compute_firewall" "firewall_ssh" {
  project = var.project
  name    = "default-allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.source_ranges
}