output "subnetworks_ranges" {
  value = [ for subnetwork in google_compute_subnetwork.subnetworks : subnetwork.ip_cidr_range ]
}
