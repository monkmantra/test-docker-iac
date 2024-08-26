locals {
  app_name = lower("${var.app_name}")
}
data "google_compute_subnetwork" "subnet-1" {
  name    = "subnet-1"
  region  = var.region
  project = var.project_id
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "noauth" {
  project = google_cloud_run_v2_service.default.project
  location = google_cloud_run_v2_service.default.location
  name = google_cloud_run_v2_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_v2_service" "default" {
  project  = var.project_id
  name     = local.app_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = "sa-cicd@${var.project_id}.iam.gserviceaccount.com"
    containers {
      name  = "idp-app"
      ports {
        container_port = 8000
      }
      image   = "us-east4-docker.pkg.dev/${var.project_id}/python-fastapi/${local.app_name}:latest"
      # image = "httpd:latest"
    }
    vpc_access {
      egress    = "ALL_TRAFFIC"
      network_interfaces {
        network = replace(data.google_compute_subnetwork.subnet-1.network, "https://www.googleapis.com/compute/v1/", "")
        subnetwork = data.google_compute_subnetwork.subnet-1.name
      }
    }
  }

  labels = {
          environment = "development"
          app_type = "fastapi"
          cost_center = ""
          irisk_id = ""
          app_name = local.app_name
      }
}