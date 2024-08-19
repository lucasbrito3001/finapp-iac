# resource "google_compute_instance" "openvpn_vm" {
#   name         = var.openvpn_vm_config.name
#   zone         = var.openvpn_vm_config.zone
#   machine_type = var.openvpn_vm_config.machine_type

#   tags = [ "allow-ssh", "allow-http", "allow-https"]

#   network_interface {
#     network    = google_compute_network.main_vpc.name
#     subnetwork = google_compute_subnetwork.gke_dev_subnetwork.name
#   }

#   boot_disk {
#     auto_delete = true

#     initialize_params {
#       size  = var.openvpn_vm_config.boot_disk_size
#       image = var.openvpn_vm_config.boot_disk_image
#     }
#   }
# }
