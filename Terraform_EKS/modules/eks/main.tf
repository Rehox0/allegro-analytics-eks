resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-eks-cluster"
  role_arn = var.cluster_role_arn
  version  = "1.35"

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [var.eks_nodes_sg_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  # Logs for CKS
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}