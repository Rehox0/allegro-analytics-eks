resource "aws_iam_openid_connect_provider" "eks" {
  url = var.eks_oidc_url

  client_id_list = ["sts.amazonaws.com"]

  tags = var.common_tags
}
