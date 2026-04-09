variable "common_tags" {
  description = "Tags passed from the environment"
  type        = map(string)
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID from the network module"
}

variable "eks_cluster_sg_id" {
  type        = string
  description = "SG ID from the EKS cluster"
}

variable "alb_ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "IP ranges that can connect to the ALB"
}