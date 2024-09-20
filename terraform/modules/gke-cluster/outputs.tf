output "master_version" {
  value = google_container_cluster.gke.master_version
}

output "gke_self_link" {
  value = google_container_cluster.gke.self_link
}
