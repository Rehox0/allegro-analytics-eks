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

variable "github_oidc_repository" {
  type        = string
  description = "GitHub repository in OWNER/REPO format allowed to assume the GitHub Actions role"
  default     = ""
}

variable "github_oidc_subjects" {
  type        = list(string)
  description = "Allowed OIDC token 'sub' claims for GitHub Actions (for example: repo:owner/repo:environment:dev)"
  default     = []
}

variable "github_oidc_role_name" {
  type        = string
  description = "IAM role name for GitHub Actions OIDC access"
  default     = "github-actions-terraform-ssm-role"
}

variable "github_oidc_provider_arn" {
  type        = string
  description = "Existing GitHub OIDC provider ARN. When set, module will not create a new provider"
  default     = ""
}

variable "github_oidc_thumbprint_list" {
  type        = list(string)
  description = "Thumbprints for GitHub's OIDC provider certificate chain"
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}
