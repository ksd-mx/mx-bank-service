variable "eks_cluster_name" {
    description = "Name of the cluster."
    type = string
}

variable "cluster_autoscaler_helm_version" {
    description = "Cluster autoscaler Helm version."
    type = string
}

variable "oidc_provider_arn" {
    description = "IAM OpenId Connect Provider ARN."
    type = string
}

variable "istio-namespace" {
    description = "Istio namespace."
    type = string
    default = "istio-system"
}