locals {
  tags = {
    Project     = var.project_name
    Environment = "staging"
    ManagedBy   = "Terraform"
  }

  cluster_name = "${var.project_name}-eks-cluster"
}
