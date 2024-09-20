# vpc
resource "google_compute_network" "central_vpc" {
  name                            = var.central_vpc_name
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  project                         = var.project
}

resource "google_compute_subnetwork" "subnetworks" {
  for_each = var.subnetworks_configs

  name          = each.value.subnetwork_name
  network       = google_compute_network.central_vpc.name
  region        = each.value.subnetwork_region
  ip_cidr_range = each.value.subnetwork_ip_range

  private_ip_google_access = true

  secondary_ip_range = each.value.secondary_ip_ranges
}

# cloud nat
resource "google_compute_route" "central_vpc_route" {
  name             = "central-vpc-route"
  network          = google_compute_network.central_vpc.name
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  project          = var.project
}

resource "google_compute_router" "router" {
  for_each = var.routers_regions

  name    = "router-${each.value}"
  region  = each.value
  network = google_compute_network.central_vpc.id
}

resource "google_compute_router_nat" "router_nat" {
  for_each = var.routers_regions

  name                               = "nat-${each.value}"
  router                             = google_compute_router.router[each.key].name
  region                             = var.nat_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  auto_network_tier                  = "STANDARD"
  project                            = var.project

  log_config {
    enable = true
    filter = "ALL"
  }
}
