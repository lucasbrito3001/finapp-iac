resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "GitHub Actions Workflows Service Account"
  project      = var.project
}

resource "google_service_account" "finapp_ms_reports" {
  account_id = "finapp-ms-reports"
  project    = var.project
}

resource "google_project_iam_member" "finapp_ms_reports_roles" {
  for_each = toset(var.finapp_ms_reports_sa_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "github_actions_roles" {
  for_each = toset(var.github_actions_sa_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}
