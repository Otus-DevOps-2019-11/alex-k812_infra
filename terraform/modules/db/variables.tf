variable project {
  description = "Project ID"
}
variable pubkeypath {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable prvkeypath {
  description = "Path to the private key used for ssh access"
}
variable disk_image_db {
  description = "Disk image"
  default     = "reddit-base-db"
}
variable zone {
  default     = "europe-west1-b"
  description = "Default instance zone"
}
