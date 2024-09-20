output "sa_finapp_ms_reports_email" {
  value = google_service_account.finapp_ms_reports.email
}

output "bucket_finapp_ms_reports_url" {
  value = google_storage_bucket.finapp_reports_storage.url
}
