module "reports_bucket" {
  source = "./modules/reports-storage"

  finapp_ms_reports_sa_roles = ["roles/storage.objectAdmin"]
  project                    = var.project
  reports_bucket_region      = "us-east1"
}

# module "central_networks" {
#   source = "./modules/central_networks"

#   central_vpc_name    = var.vpc_name
#   nat_region          = "us-east1"
#   project             = var.project
#   subnetworks_configs = var.subnetworks_configs
#   routers_regions     = ["us-east1"]
# }

# module "gke_dev_cluster" {
#   source = "./modules/gke-cluster"

#   project                                 = var.project
#   gke_name                                = "gke-dev-cluster"
#   gke_network                             = var.vpc_name
#   gke_subnetwork                          = var.subnetworks_configs.gke_dev_subnet.subnetwork_name
#   gke_pods_subnetwork                     = var.subnetworks_configs.gke_dev_subnet.secondary_ip_ranges[0].range_name
#   gke_services_subnetwork                 = var.subnetworks_configs.gke_dev_subnet.secondary_ip_ranges[1].range_name
#   gke_region                              = var.gke_dev_region
#   gke_zone                                = var.gke_dev_zone
#   gke_master_authorized_networks_ip_range = "0.0.0.0/0"
#   gke_master_ipv4_cidr_block              = "10.0.255.240/28"
#   gke_node_pool_name                      = "np-general0"
#   gke_node_pool_max_pods_per_node         = 110
#   gke_node_pool_min_node_count            = 1
#   gke_node_pool_max_node_count            = 2
#   gke_node_pool_instance_type             = "e2-standard-2"
#   gke_node_pool_disk_size                 = 30
#   gke_node_pool_image_type                = "cos_containerd"

#   gke_node_pool_tags = ["gke-vms", "np-general0"]

#   gke_node_pool_labels = {
#     node-usage = "services"
#   }

#   gke_node_pool_oauth_scopes = [
#     "https://www.googleapis.com/auth/devstorage.read_only",
#     "https://www.googleapis.com/auth/logging.write",
#     "https://www.googleapis.com/auth/monitoring",
#   ]
# }
