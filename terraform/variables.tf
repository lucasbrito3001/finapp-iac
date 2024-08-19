variable "project" {
  type    = string
  default = "gcp-testing-431723"
}

variable "gke_dev_region" {
  type    = string
  default = "us-east1"
}

variable "gke_dev_zone" {
  type    = string
  default = "us-east1-b"
}

variable "gke_dev_node_pool_instance_type" {
  type    = string
  default = "e2-standard-4"
}

variable "gke_dev_subnet_range" {
  type    = string
  default = "10.0.0.0/24"
}

variable "gke_dev_subnet_pods_range" {
  type    = string
  default = "10.0.2.0/23"
}

variable "gke_dev_subnet_services_range" {
  type    = string
  default = "10.0.4.0/23"
}

variable "openvpn_vm_config" {
  type = object({
    name            = string
    machine_type    = string
    boot_disk_image = string
    boot_disk_size  = number
    zone            = string
  })

  default = {
    name            = "openvpn-vm"
    machine_type    = "e2-standard-2"
    boot_disk_image = "ubuntu-os-cloud/ubuntu-2204-lts"
    boot_disk_size  = 10
    zone            = "us-east1-b"
  }
}

variable "github_actions_sa_roles" {
  type    = list(string)
  default = ["roles/container.serviceAgent", "roles/container.clusterViewer", "roles/secretmanager.admin"]
}

variable "ms_finapp_inout_db_env" {
  type    = string
}
