data "aws_iam_openid_connect_provider" "cluster_loadbalancer" {
  arn = var.openid_provider_arn
}

data "aws_iam_policy_document" "cluster_loadbalancer" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_iam_openid_connect_provider.cluster_loadbalancer.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.cluster_loadbalancer.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "cluster_loadbalancer" {
  assume_role_policy = data.aws_iam_policy_document.cluster_loadbalancer.json
  name               = "${var.eks_cluster_name}-cluster-loadbalancer"
}

resource "aws_iam_policy" "cluster_loadbalancer" {
  policy     = file("./cluster_loadbalancer_policy.json")
  name       = "${var.eks_cluster_name}-cluster-loadbalancer"
}

resource "aws_iam_role_policy_attachment" "cluster_loadbalancer" {
  role = aws_iam_role.cluster_loadbalancer.name
  policy_arn = aws_iam_policy.cluster_loadbalancer.arn
}

resource "helm_release" "cluster_loadbalancer" {
  name = "loadbalancer"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system" 
  version    = var.cluster_loadbalancer_helm_version

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "image.tag"
    value = "v2.4.2"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cluster_loadbalancer.arn
  }
}