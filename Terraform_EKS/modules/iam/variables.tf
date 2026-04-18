variable "common_tags" {
  description = "Tags passed from the environment"
  type        = map(string)
}

variable "project_name" { type = string }

variable "cluster_name" {
  type        = string
  description = "EKS cluster name used for access entry management"
}

variable "eks_oidc_url" {
  type        = string
  description = "Issuer URL from the EKS cluster (provided after the cluster is created)"
  default     = ""
}

variable "secret_arn" { type = string }

variable "eks_console_user_principal_arn" {
  type        = string
  description = "Optional IAM principal ARN (typically IAM User) granted EKS cluster admin access entry"
  default     = ""
}
