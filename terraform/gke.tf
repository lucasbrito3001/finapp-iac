resource "google_container_cluster" "gke_dev" {
  provider = google-beta

  name                = "gke-dev"
  network             = google_compute_network.main_vpc.name
  subnetwork          = google_compute_subnetwork.gke_dev_subnetwork.name
  deletion_protection = false
  project             = var.project
  location            = var.gke_dev_zone

  initial_node_count       = 1
  remove_default_node_pool = true

  default_max_pods_per_node = 32

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  # network_policy {
  #   enabled  = true
  #   provider = "CALICO"
  # }

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
      cidr_block = "0.0.0.0/0"
    }
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "10.0.255.240/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.gke_dev_subnetwork.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.gke_dev_subnetwork.secondary_ip_range[1].range_name
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

resource "google_container_node_pool" "gke_dev_node_pool" {
  name     = "gke-dev-node-pool"
  cluster  = google_container_cluster.gke_dev.name
  location = var.gke_dev_zone

  max_pods_per_node = 32

  network_config {
    create_pod_range     = false
    enable_private_nodes = true
  }

  autoscaling {
    location_policy = "BALANCED"
    min_node_count  = 1
    max_node_count  = 2
  }

  node_config {
    machine_type                = var.gke_dev_node_pool_instance_type
    disk_type                   = "pd-standard"
    disk_size_gb                = 50
    image_type                  = "cos_containerd"
    enable_confidential_storage = false

    tags = ["gke-vms"]

    labels = {
      node-usage = "services"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

  }
}
