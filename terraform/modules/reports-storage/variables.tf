variable "project" {
  type    = string
  default = "gcp-testing-431723"
}

variable "reports_bucket_region" {
  type    = string
  default = "us-east1"
}

variable "finapp_ms_reports_sa_roles" {
  type    = list(string)
  default = ["roles/storage.objectAdmin"]
}
