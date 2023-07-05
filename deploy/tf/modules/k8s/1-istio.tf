locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
}

resource "helm_release" "istio-base" {
  repository  = local.istio_charts_url
  chart       = "base"
  name        = "istio-base"
  create_namespace = true
  namespace   = "istio-system"
}

resource "helm_release" "istiod" {
  repository  = local.istio_charts_url
  chart       = "istiod"
  name        = "istio-istiod"
  create_namespace = true
  namespace   = "istio-system"
  depends_on  = [helm_release.istio-base]
}