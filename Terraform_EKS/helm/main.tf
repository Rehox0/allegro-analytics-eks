resource "helm_release" "aws_lb_controller" {
  name            = "aws-load-balancer-controller"
  repository      = "https://aws.github.io/eks-charts"
  chart           = "aws-load-balancer-controller"
  version         = var.alb_controller_chart_version
  namespace       = "kube-system"
  cleanup_on_fail = true

  set = [
    {
      name  = "clusterName"
      value = var.cluster_name
    },
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "vpcId"
      value = var.vpc_id
    },
    {
      name  = "region"
      value = var.aws_region
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.alb_controller_role_arn
    }
  ]

  depends_on = [helm_release.cilium]
}

resource "helm_release" "cilium" {
  name            = "cilium"
  repository      = "https://helm.cilium.io/"
  chart           = "cilium"
  version         = var.cilium_chart_version
  namespace       = "kube-system"
  cleanup_on_fail = true
  timeout         = 600

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
      name  = "bpf.masquerade"
      value = "true"
    },
    {
      name  = "enableIPv4Masquerade"
      value = "true"
    },
    {
      name  = "routingMode"
      value = "native"
    },
    {
      name  = "kubeProxyReplacement"
      value = "true"
    },
    {
      name  = "k8sServiceHost"
      value = replace(var.cluster_endpoint, "https://", "")
    },
    {
      name  = "k8sServicePort"
      value = "443"
    },
    {
      name  = "installNoConntrackIptablesRules"
      value = "true"
    },
    {
      name  = "hubble.enabled"
      value = "true"
    },
    {
      name  = "hubble.relay.enabled"
      value = "true"
    },
    {
      name  = "hubble.ui.enabled"
      value = "true"
    },
    {
      name  = "vlanBPF.enabled"
      value = "true"
    },
    {
      name  = "hubble.tls.enabled"
      value = "true"
    },
    {
      name  = "hubble.tls.auto.method"
      value = "helm"
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.cilium_role_arn
    }
  ]
}
