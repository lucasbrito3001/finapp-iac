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

resource "google_container_cluster" "gke" {
  provider = google-beta

  name                = var.gke_name
  network             = var.gke_network
  subnetwork          = var.gke_subnetwork
  deletion_protection = false
  project             = var.project
  location            = var.gke_zone

  initial_node_count       = 1
  remove_default_node_pool = true

  default_max_pods_per_node = 110

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  default_snat_status {
    disabled = false
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled = true

    cidr_blocks {
      cidr_block = var.gke_master_authorized_networks_ip_range
    }
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.gke_pods_subnetwork
    services_secondary_range_name = var.gke_services_subnetwork
  }

  secret_manager_config {
    enabled = true
  }

  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }
}

resource "google_container_node_pool" "gke_node_pool" {
  name     = var.gke_node_pool_name
  cluster  = google_container_cluster.gke.name
  location = var.gke_zone

  max_pods_per_node = var.gke_node_pool_max_pods_per_node

  network_config {
    create_pod_range     = false
    enable_private_nodes = true
  }

  autoscaling {
    location_policy = "BALANCED"
    min_node_count  = var.gke_node_pool_min_node_count
    max_node_count  = var.gke_node_pool_max_node_count
  }

  node_config {
    machine_type                = var.gke_node_pool_instance_type
    disk_type                   = "pd-standard"
    disk_size_gb                = var.gke_node_pool_disk_size
    image_type                  = var.gke_node_pool_image_type
    enable_confidential_storage = false

    tags = var.gke_node_pool_tags

    labels = var.gke_node_pool_labels

    oauth_scopes = var.gke_node_pool_oauth_scopes

  }
}
