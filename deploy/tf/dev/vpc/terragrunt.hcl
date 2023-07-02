terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.0.0"
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
  prefix          = "${include.env.locals.env}-${include.root.locals.namespace}"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

inputs = {
  name = "${local.prefix}-vpc"

  cidr = "10.0.0.0/16"

  azs             = local.azs
  private_subnets = local.private_subnets
}