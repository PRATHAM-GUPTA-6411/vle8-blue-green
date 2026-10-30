resource "aws_security_group" "vle8_terraform_sg" {
  name        = "VLE8-Terraform-SG"
  description = "Security group provisioned using Terraform for VLE-8"
  vpc_id      = "vpc-06b2267c6ee1aeaa4"

  tags = {
    Name    = "VLE8-Terraform-SG"
    Project = "VLE-8-Blue-Green"
  }
}

locals {
  project_name        = "vle8-blue-green"
  deployment_strategy = "blue-green"

  reused_instance_id   = "i-00f0d76ccf9d042d5"
  reused_instance_type = "m7i-flex.large"
}
