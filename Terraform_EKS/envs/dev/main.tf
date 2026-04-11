
module "vpc" {
  source               = "../../modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  availability_zones   = ["${var.aws_region}a", "${var.aws_region}b"]
  endpoints_sg_id      = module.security_groups.endpoints_sg_id
  
  cluster_name         = "${var.project_name}-cluster"
  common_tags          = local.tags
}

module "eks" {
  source               = "../../modules/eks"
  
  project_name         = var.project_name
  cluster_name         = "${var.project_name}-cluster"

  cluster_role_arn     = module.iam.eks_cluster_role_arn
  node_role_arn        = module.iam.node_role_arn

  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_subnets

  eks_nodes_sg_id      = module.security_groups.eks_nodes_sg_id
  node_instance_types  = ["t3.small"]
  node_desired_size    = 2
  node_min_size        = 1
  node_max_size        = 3
  node_max_unavailable = 1
  node_labels = {
    env  = "dev"
  }

  common_tags          = local.tags
}

module "security_groups" {
  source               = "../../modules/security_groups"
  
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  management_sg_id     = module.security_groups.management_sg_id
  common_tags          = local.tags
  
  eks_cluster_sg_id    = module.eks.cluster_primary_security_group_id
}

module "iam" {
  source               = "../../modules/iam"
  project_name         = var.project_name
  cluster_oidc_issuer  = module.eks.cluster_oidc_issuer 
  secret_arn           = data.aws_secretsmanager_secret.manual_secrets.arn
  common_tags          = local.tags
}

module "helm_charts" {
  source                  = "../../helm"

  aws_region              = var.aws_region
  vpc_id                  = module.vpc.vpc_id
  cluster_name            = module.eks.cluster_name
  cluster_endpoint        = module.eks.cluster_endpoint
  cluster_ca_certificate  = module.eks.cluster_certificate_authority_data
  
  alb_controller_role_arn = module.iam.alb_controller_role_arn
  cilium_role_arn         = module.iam.cilium_operator_role_arn
  eks_nodes_sg_id         = module.eks.node_security_group_id

  depends_on              = [module.eks, module.iam]
}

module "management" {
  source                  = "../../modules/management"
  
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets 
  instance_profile_name   = module.iam.management_instance_profile_name
  management_sg_id        = module.security_groups.management_sg_id
  
  ami_id                  = "ami-0ed07612c75a46f25"
  user_data_script        = <<-EOT
    #!/bin/bash
    sudo dnf install -y terraform kubectl
  EOT
}