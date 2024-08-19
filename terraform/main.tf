terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.41.0"
    }
  }
}

provider "google" {
  project = var.project
}

provider "google-beta" {
  project = "my-project-id"
}
