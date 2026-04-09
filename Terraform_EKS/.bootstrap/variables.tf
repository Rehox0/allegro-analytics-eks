variable "project_name" {
  description = "Project name"
  type        = string
  default     = "allegro-analytics-eks"
}

variable "aws_region" {
  description = "region for s3"
  type        = string
  default     = "eu-north-1"
}

variable "state_bucket_name" {
  description = "Full s3 name for .tfstate"
  type        = string
  default     = "allegro-analytics-eks-tfstate-2026" 
}