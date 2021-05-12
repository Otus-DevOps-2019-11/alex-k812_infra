terraform {
  # Версия terraform
  required_version = "~>0.12.8"
}

provider "google" {
  version = "2.15"
  project = var.project
  region  = var.region
}

module "app" {
  source         = "../modules/app"
  project        = var.project
  pubkeypath     = var.pubkeypath
  prvkeypath     = var.prvkeypath
  zone           = var.zone
  disk_image_app = var.disk_image_app
  dbip           = module.db.db_int_ip
}

module "db" {
  source        = "../modules/db"
  project       = var.project
  pubkeypath    = var.pubkeypath
  prvkeypath    = var.prvkeypath
  zone          = var.zone
  disk_image_db = var.disk_image_db
}

module "vpc" {
  source        = "../modules/vpc"
  project       = var.project
  source_ranges = ["196.39.174.4/32"]
}