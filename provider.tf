terraform {
  backend "gcs" {
    bucket  = "tf-state-learning-poc"
    prefix  = "infra-test-docker"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
  }
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.project_id
}
