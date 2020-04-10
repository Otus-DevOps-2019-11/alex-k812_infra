resource "google_compute_address" "appip" {
  name = "reddit-app-ip"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["puma-server"]
  boot_disk {
    initialize_params {
      image = var.disk_image_app
    }
  }
  count = var.vmcount
  metadata = {
    ssh-keys = "ak:${file(var.pubkeypath)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "ak"
    agent       = false
    private_key = file(var.prvkeypath)
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.appip.address
    }
  }

#  provisioner "remote-exec" {
#    inline = [
#      "echo export DATABASE_URL=\"${var.dbip}\" >> ~/.profile"
#    ]
#  }
#
#  provisioner "remote-exec" {
#    script = "${path.module}/files/deploy.sh"
#  }
#
#  provisioner "file" {
#    source      = "${path.module}/files/puma.service"
#    destination = "/tmp/puma.service"
#    destination = "/etc/systemd/system/puma.service"
#  }
}

resource "google_compute_firewall" "firewall_puma" {
  project = var.project
  name    = "default-puma-server"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["puma-server"]
}
