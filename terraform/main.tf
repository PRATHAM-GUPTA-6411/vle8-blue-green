# VLE-8 Blue-Green Deployment
# AWS infrastructure configuration.
# Existing VLE-7 EC2 infrastructure is reused.
# This file does not create or modify AWS resources.

locals {
  project_name = "vle8-blue-green"
  aws_region   = "ap-south-1"

  components = [
    "jenkins",
    "docker",
    "kubernetes",
    "blue-deployment",
    "green-deployment"
  ]

  deployment_strategy = "blue-green"
}
