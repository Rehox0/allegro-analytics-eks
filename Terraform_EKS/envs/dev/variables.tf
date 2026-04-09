variable "project_name" {
    description = "Name for the project"
    type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "common_tags" {
  type        = map(string)
    description = "Standard tags for all assets in the project"
    default = {
      Project     = "allegro-analytics-eks"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
}