data "tls_certificate" "eks" {
  url   = var.cluster_oidc_issuer
}

data "http" "iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
}