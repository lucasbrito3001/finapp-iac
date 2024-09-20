resource "google_service_account" "finapp_ms_reports" {
  account_id = "finapp-ms-reports"
  project    = var.project
}

resource "google_project_iam_member" "finapp_ms_reports_roles" {
  for_each = toset(var.finapp_ms_reports_sa_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.finapp_ms_reports.email}"
}

resource "google_storage_bucket" "finapp_reports_storage" {
  name          = "finapp-reports-storage"
  location      = var.reports_bucket_region
  project       = var.project
  force_destroy = true

  uniform_bucket_level_access = true
}

# resource "google_storage_managed_folder" "montlhy_expenses" {
#   name   = "monthy-expenses"
#   bucket = google_storage_bucket.finapp_reports_storage.name
# }
