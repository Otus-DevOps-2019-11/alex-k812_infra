resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["db-server"]
  boot_disk {
    initialize_params {
      image = var.disk_image_db
    }
  }
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
    access_config {}
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf",
      "sudo systemctl restart mongod",
    ]
  }
} 

  resource "google_compute_firewall" "firewall_mongo" {
    project = var.project
    name    = "default-mongo-server"
    network = "default"
    allow {
      protocol = "tcp"
      ports    = ["27017"]
    }
    source_tags = ["app-server"]
    target_tags = ["db-server"]
}
