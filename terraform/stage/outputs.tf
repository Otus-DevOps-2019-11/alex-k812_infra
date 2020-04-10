output "app_external_ip" {
  value = module.app.app_external_ip
  #  value = google_compute_instance.app[*].network_interface[0].access_config[0].nat_ip
}
output "db_ip" {
  value = module.db.db_int_ip
  #  value = google_compute_instance.db.network_interface[0].network_ip
}
#output "lb_ext_ip" {
#  value = google_compute_global_address.default.address
#}