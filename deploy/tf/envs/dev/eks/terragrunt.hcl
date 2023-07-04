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
  cluster_name    = "${local.prefix}-eks"
  cluster_version = "1.27"

  vpc_id  = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets
  
  cluster_encryption_config	= {}
  
  create_kms_key = false
  cluster_endpoint_public_access = true
  create_cloudwatch_log_group	= false
  create_iam_role = true

  enable_irsa = true

  fargate_profiles = {
    default = {
      name = include.root.locals.namespace
      selectors = [
        {
          namespace = include.root.locals.namespace

          subnet_ids = dependency.vpc.outputs.private_subnets
        }
      ]
    }
  }
}

dependency "vpc" {
  config_path = "../vpc"
}