# test-docker - Infra as Code

This repo has the following:
- Terraform module to create a Cloud Run instance
- Terraform module to create a Cloud Spanner database
- GitHub Actions CD pipeline to provision the above resources in GCP Project ***png-gcp-learning-poc*** and then deploy the Docker image for ***test-docker*** application from Artifact Registry

## Getting started

Start writing your documentation by replacing the content in this file and/or adding more markdown (.md) files to this folder (/docs).
