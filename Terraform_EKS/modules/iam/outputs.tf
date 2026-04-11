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