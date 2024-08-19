resource "google_compute_firewall" "allow_https_egress" {
  name     = "allow-https-egress"
  network  = google_compute_network.main_vpc.name
  project  = var.project
  priority = 1000
  # enable_logging = true

  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # source_tags = ["gke-vms"]
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http_ingress" {
  name     = "allow-http-ingress"
  network  = google_compute_network.main_vpc.name
  project  = var.project
  priority = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }


  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-http"]
}

resource "google_compute_firewall" "allow_https_ingress" {
  name     = "allow-https-ingress"
  network  = google_compute_network.main_vpc.name
  project  = var.project
  priority = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }


  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-https"]
}

resource "google_compute_firewall" "allow_ssh_ingress" {
  name     = "allow-ssh-ingress"
  network  = google_compute_network.main_vpc.name
  project  = var.project
  priority = 1000

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-ssh"]
}

resource "google_compute_firewall" "allow_health_checks_ingress" {
  name     = "allow-health-checks-ingress"
  network  = google_compute_network.main_vpc.name
  project  = var.project
  priority = 1000

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges      = ["130.211.0.0/22", "35.191.0.0/16"]
  destination_ranges = ["10.0.0.0/8"]
}
