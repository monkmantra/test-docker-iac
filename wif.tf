module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version     = "~> 3.1"
  project_id  = var.project_id
  pool_id     = "github-platonic-cosmos-pool"
  provider_id = "github-platonic-cosmos-provider"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "attribute.repository_owner == \"platonic-cosmos\""
  sa_mapping = {
    (data.google_service_account.sa-cicd.account_id) = {
      sa_name   = data.google_service_account.sa-cicd.name
      attribute = "attribute.repository_owner/platonic-cosmos",
    }
  }
}

data google_service_account "sa-cicd" {
    project = var.project_id
    account_id = "sa-cicd"
}