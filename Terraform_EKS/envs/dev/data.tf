data "aws_secretsmanager_secret" "manual_secrets" {
  name = var.secrets_name
}

data "aws_eks_cluster_auth" "main" {
  name = module.eks.cluster_name
}

data "aws_secretsmanager_secret_version" "manual_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.manual_secrets.id
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_ecr_repository" "frontend" {
  name = var.ecr_frontend_name
}

data "aws_ecr_repository" "backend" {
  name = var.ecr_backend_name
}