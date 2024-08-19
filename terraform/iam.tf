resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "GitHub Actions Workflows Service Account"
  project      = var.project
}

resource "google_project_iam_member" "sa_iam" {
  for_each = toset(var.github_actions_sa_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}
