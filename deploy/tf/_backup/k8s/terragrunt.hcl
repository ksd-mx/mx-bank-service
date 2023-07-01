terraform {
  source = "../../../modules/k8s"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  env                             = include.env.locals.env
  eks_cluster_name                = dependency.eks.outputs.eks_cluster_name
  openid_provider_arn             = dependency.eks.outputs.openid_provider_arn
  enable_cluster_autoscaler       = true
  cluster_autoscaler_helm_version = "9.28.0"
  cluster_loadbalancer_helm_version = "1.4.1"
}

dependency "eks" {
  config_path = "../eks"
}

generate "helm_provider" {
  path      = "helm_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    data "aws_eks_cluster" "eks" {
        name = var.eks_cluster_name
    }
    data "aws_eks_cluster_auth" "eks" {
        name = var.eks_cluster_name
    }
    provider "helm" {
      kubernetes {
        host                   = data.aws_eks_cluster.eks.endpoint
        cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
        token                  = data.aws_eks_cluster_auth.eks.token
      }
    }
    EOF
}