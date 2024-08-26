# test-docker - Infra as Code

This repo has the following:
- Terraform module to create a Cloud Run instance
- Terraform module to create a Cloud Spanner database
- GitHub Actions CD pipeline to provision the above resources in GCP Project ***png-gcp-learning-poc*** and then deploy the Docker image for ***test-docker*** application from Artifact Registry

