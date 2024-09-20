variable "project" {
  type = string
}

variable "central_vpc_name" {
  type = string
}

variable "subnetworks_configs" {
  type = map(
    object({
      subnetwork_name     = string
      subnetwork_region   = string
      subnetwork_ip_range = string
      secondary_ip_ranges = list(object({
        range_name    = string
        ip_cidr_range = string
      }))
    })
  )
}

variable "routers_regions" {
  type = set(string)
}

variable "nat_region" {
  type = string
}
