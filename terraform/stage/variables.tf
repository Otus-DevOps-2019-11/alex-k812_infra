variable project {
  description = "Project ID"
}
variable name {
  default = "reddit-app"
}
variable region {
  description = "Default instance region"
  # Значение по умолчанию
  default = "europe-west1"
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
variable disk_image_db {
  description = "Disk image"
  default     = "reddit-base-db"
}
variable zone {
  default     = "europe-west1-b"
  description = "Default instance zone"
}
variable sshuser {
  type        = list(string)
  description = "List of ssh users"
}
variable vmcount {
  default = 1
}