locals {
  github_oidc_enabled         = var.github_oidc_repository != "" && length(var.github_oidc_subjects) > 0
  github_oidc_create_provider = local.github_oidc_enabled && var.github_oidc_provider_arn == ""
  github_oidc_effective_arn   = var.github_oidc_provider_arn != "" ? var.github_oidc_provider_arn : try(aws_iam_openid_connect_provider.github[0].arn, "")
}
