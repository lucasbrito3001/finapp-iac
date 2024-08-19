resource "google_compute_network" "main_vpc" {
  name                            = "main-vpc"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  project                         = var.project
}

resource "google_compute_subnetwork" "gke_dev_subnetwork" {
  name                     = "gke-dev-subnet"
  network                  = google_compute_network.main_vpc.name
  region                   = var.gke_dev_region
  private_ip_google_access = true

  ip_cidr_range = var.gke_dev_subnet_range
  secondary_ip_range = [
    {
      ip_cidr_range = var.gke_dev_subnet_pods_range
      range_name    = "gke-dev-pods-subnet"
    },
    {
      ip_cidr_range = var.gke_dev_subnet_services_range
      range_name    = "gke-dev-services-subnet"
    }
  ]
}

resource "google_compute_route" "main_vpc_route" {
  name             = "main-vpc-route"
  network          = google_compute_network.main_vpc.name
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  project          = var.project
}

resource "google_compute_router" "main_router" {
  name    = "main-router"
  region  = google_compute_subnetwork.gke_dev_subnetwork.region
  network = google_compute_network.main_vpc.id
}

resource "google_compute_router_nat" "main_router_nat" {
  name                               = "main-router-nat"
  router                             = google_compute_router.main_router.name
  region                             = google_compute_router.main_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  auto_network_tier                  = "STANDARD"
  project                            = var.project

  log_config {
    enable = true
    filter = "ALL"
  }
}
