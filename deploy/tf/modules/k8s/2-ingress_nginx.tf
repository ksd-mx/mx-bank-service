resource "helm_release" "nginx_ingress" {
  name        = "beta-nginx"
  repository  = "https://kubernetes.github.io/ingress-nginx"
  chart       = "ingress-nginx"
  namespace  = "kube-system"
  set {
    name  = "controller.service.type"
    value = "NodePort"
  }
}