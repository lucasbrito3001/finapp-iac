resource "google_secret_manager_secret" "ms_finapp_inout_db_env" {
  secret_id = "ms-finapp-inout-env"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ms_finapp_inout_db_env_version" {
  secret = google_secret_manager_secret.ms_finapp_inout_db_env.id

  secret_data = var.ms_finapp_inout_db_env
}
