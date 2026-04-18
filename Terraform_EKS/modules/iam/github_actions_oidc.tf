resource "aws_iam_openid_connect_provider" "github" {
  count = local.github_oidc_create_provider ? 1 : 0

  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.github_oidc_thumbprint_list

  tags = var.common_tags
}

resource "aws_iam_role" "github_actions" {
  count = local.github_oidc_enabled ? 1 : 0
  name  = var.github_oidc_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = local.github_oidc_effective_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = var.github_oidc_subjects
          }
        }
      },
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy" "github_actions_ssm_runner" {
  count = local.github_oidc_enabled ? 1 : 0
  name  = "${var.github_oidc_role_name}-ssm-runner"
  role  = aws_iam_role.github_actions[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ManagementAsgLookup"
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
        ]
        Resource = "*"
      },
      {
        Sid    = "ManagementInstanceLookup"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
        ]
        Resource = "*"
      },
      {
        Sid    = "RunTerraformViaSsm"
        Effect = "Allow"
        Action = [
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:ListCommandInvocations",
          "ssm:CancelCommand",
        ]
        Resource = "*"
      },
    ]
  })
}
