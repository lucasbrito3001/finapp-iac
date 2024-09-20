variable "project" {
  type = string
  # default = "gcp-testing-431723"
}

variable "gke_name" {
  type = string
}

variable "gke_network" {
  type = string
  # default = "main_vpc"
}

variable "gke_subnetwork" {
  type = string
}

variable "gke_pods_subnetwork" {
  type = string
}

variable "gke_services_subnetwork" {
  type = string
}

variable "gke_region" {
  type = string
  # default = "us-east1"
}

variable "gke_zone" {
  type = string
  # default = "us-east1-b"
}

variable "gke_master_authorized_networks_ip_range" {
  type = string
}

variable "gke_master_ipv4_cidr_block" {
  type = string
  # default = "10.0.255.240/28"
}

variable "gke_node_pool_name" {
  type = string
}

variable "gke_node_pool_max_pods_per_node" {
  type = number
}

variable "gke_node_pool_min_node_count" {
  type = number
}

variable "gke_node_pool_max_node_count" {
  type = number
}

variable "gke_node_pool_instance_type" {
  type = string
  # default = "e2-standard-4"
}

variable "gke_node_pool_disk_size" {
  type = number
}

variable "gke_node_pool_image_type" {
  type = string
}

variable "gke_node_pool_tags" {
  type = list(string)
}

variable "gke_node_pool_labels" {
  type = map(string)
}

variable "gke_node_pool_oauth_scopes" {
  type = set(string)
  # default = [
  #   "https://www.googleapis.com/auth/devstorage.read_only",
  #   "https://www.googleapis.com/auth/logging.write",
  #   "https://www.googleapis.com/auth/monitoring",
  # ]
}
