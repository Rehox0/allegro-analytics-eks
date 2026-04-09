variable "common_tags" {
  description = "Tags passed from the environment"
  type        = map(string)
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "cluster_oidc_issuer" {
  type        = string
  description = "Issuer URL from the EKS cluster (provided after the cluster is created)"
  default     = ""
}

variable "secret_arn" {
  type = string
}