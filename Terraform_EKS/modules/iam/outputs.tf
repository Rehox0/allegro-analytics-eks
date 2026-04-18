output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_nodes.arn
}

output "alb_controller_role_arn" {
  value       = aws_iam_role.alb_controller.arn
  description = "ARN of the IAM role for the AWS Load Balancer Controller"
}

output "cilium_operator_role_arn" {
  value       = aws_iam_role.cilium_operator.arn
  description = "ARN for IAM in Cilium"
}

output "management_instance_profile_name" {
  value = aws_iam_instance_profile.management_profile.name
}

output "management_role_arn" {
  value       = aws_iam_role.management_role.arn
  description = "ARN of the management EC2 role used for Terraform operations"
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "github_actions_role_arn" {
  value       = try(aws_iam_role.github_actions[0].arn, "")
  description = "ARN of GitHub Actions IAM role (OIDC), empty when not configured"
}

output "github_oidc_provider_arn" {
  value       = local.github_oidc_effective_arn
  description = "GitHub OIDC provider ARN used by the module, empty when not configured"
}
