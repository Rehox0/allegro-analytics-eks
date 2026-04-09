resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "~> 1.19.0"
  namespace  = "kube-system"

  values = [
    yamlencode({
    operator = {
      replicas = 1
    }
    serviceAccounts = {
      operator = {
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.cilium_operator.arn
        }
      }
    }
    eni = {
      enabled = true
    }
    })
  ]

  depends_on = [aws_eks_node_group.main]
}