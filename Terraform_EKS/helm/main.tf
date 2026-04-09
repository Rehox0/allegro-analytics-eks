resource "helm_release" "aws_lb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set = [
    {
      name  = "clusterName"
      value = var.cluster_name
    },
    {
      name  = "serviceAccount.create"
      value = "true"
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.alb_controller_role_arn
    }
  ]
}

resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  namespace  = "kube-system"

  set = [
    {
      name  = "eni.enabled"
      value = "true"
    },
    {
      name  = "ipam.mode"
      value = "eni"
    },
    {
      name  = "egressGateway.enabled"
      value = "true"
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.cilium_role_arn
    }
  ]
}