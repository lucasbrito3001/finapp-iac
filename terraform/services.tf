resource "google_project_service" "gce" {
  project            = var.project
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "gke" {
  project            = var.project
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "secret_manager" {
  project            = var.project
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
}
