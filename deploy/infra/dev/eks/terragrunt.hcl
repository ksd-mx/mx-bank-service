terraform {
  source = "tfr:///terraform-aws-modules/eks/aws?version=19.15.3"
}

include "root" {
  path           = find_in_parent_folders()
  expose         = true
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

locals {
  prefix = "${include.env.locals.env}-${include.root.locals.namespace}"
}

inputs = {
  cluster_name    = local.prefix
  cluster_version = "1.26"

  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets
  
  cluster_encryption_config	= {}
  
  create_kms_key = false
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  create_cloudwatch_log_group	= false
  create_iam_role = true

  enable_irsa = true

  # cluster_addons = {
  #   coredns = {
  #     preserve    = true
  #     most_recent = true

  #     timeouts = {
  #       create = "25m"
  #       delete = "10m"
  #     }

  #     configuration_values = jsonencode({
  #       computeType = "Fargate"
  #     })
  #   }
  #   kube-proxy = {
  #     most_recent = true
  #   }
  #   vpc-cni = {
  #     most_recent = true
  #   }
  # }

  fargate_profile_defaults = {
    # pod_execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/eksctl-${local.prefix}-eks-cluster-FargatePodExecutionRole-1JQJX5QXQYJ6"
    iam_role_additional_policies = {
      1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
  }

  fargate_profiles = {
    default = {
      name = "default"
      subnet_ids = dependency.vpc.outputs.private_subnets
      create_iam_role = true
      
      selectors = [
        {
          namespace = "default"
        }
      ]
    }, 
    kube-system = {
      name = "kube-system"
      subnet_ids = dependency.vpc.outputs.private_subnets
      create_iam_role = true
      
      selectors = [
        {
          namespace = "kube-system"
        }
      ]
    },
    istio-system = {
      name = "istio-system"
      subnet_ids = dependency.vpc.outputs.private_subnets
      create_iam_role = true
      
      selectors = [
        {
          namespace = "istio-system"
        }
      ]
    }
  }
}

dependency "vpc" {
  config_path = "../vpc"
}