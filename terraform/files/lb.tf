provider "google-beta" {
  version = "~> 2.7.0"
  region  = var.region
  project = var.project
}

resource "google_compute_global_address" "default" {
  project      = var.project
  name         = "${var.name}-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_target_http_proxy" "http" {
  project = var.project
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.urlmap.self_link
}

resource "google_compute_global_forwarding_rule" "http" {
  provider   = google-beta
  project    = var.project
  name       = "${var.name}-http-rule"
  target     = google_compute_target_http_proxy.http.self_link
  ip_address = google_compute_global_address.default.address
  port_range = "80"
  depends_on = [google_compute_global_address.default]

#  labels = var.custom_labels
}

resource "google_compute_url_map" "urlmap" {
  project = var.project
  name        = "${var.name}-url-map"
  description = "URL map for ${var.name}"

  default_service = google_compute_backend_service.be.self_link
}

resource "google_compute_backend_service" "be" {
  project = var.project
  name        = "${var.name}-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false
  backend {
    group = google_compute_instance_group.appgr.self_link
  }

  health_checks = [google_compute_health_check.hc.self_link]

  depends_on = [google_compute_instance_group.appgr]
}

resource "google_compute_health_check" "hc" {
  project = var.project
  name    = "${var.name}-hc"
  http_health_check {
    port         = 9292
#    request_path = "/"
  }

  check_interval_sec = 5
  timeout_sec        = 5
}

resource "google_compute_instance_group" "appgr" {
  project   = var.project
  name      = "${var.name}-instance-group"
  zone      = var.zone
  instances = google_compute_instance.app.*.self_link
  lifecycle {
    create_before_destroy = true
  }
  named_port {
    name = "http"
    port = 9292
  }
}