variable project {
  description = "Project ID"
}
variable pubkeypath {
  description = "Path to the public key used for ssh access"
}
variable prvkeypath {
  description = "Path to the private key used for ssh access"
}
variable disk_image_app {
  description = "Disk image"
  default     = "reddit-base-app"
}
variable zone {
  default     = "europe-west1-b"
  description = "Default instance zone"
}
variable vmcount {
  default = 1
}
variable dbip {
  description = "Mongo insrance ip"
}