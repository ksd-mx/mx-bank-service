terraform {
  source = "tfr:///terraform-aws-modules/eks/aws?version=19.15.3"
}

include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "no_merge"
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
  cluster_name    = "${local.prefix}-eks-cluster"
  cluster_version = "1.27"

  vpc_id  = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets

  fargate_profiles = {
    default = {
      name = include.root.locals.namespace
      selectors = [
        {
          namespace = include.root.locals.namespace
        }
      ]
    }
  }

  # node_groups = {
  #   general = {
  #     capacity_type  = "SPOT"
  #     instance_types = ["t2.micro"]
  #     scaling_config = {
  #       desired_size = 1
  #       max_size     = 2
  #       min_size     = 0
  #     }
  #   }
  # }

  # aws-auth configmap
  # manage_aws_auth_configmap = true
}

dependency "vpc" {
  config_path = "../vpc"
}