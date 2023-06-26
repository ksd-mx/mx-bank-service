terraform {
  source = "../../../modules/api"
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
  env                = include.env.locals.env
  api_name           = "mx-bank-service"
  integration_url    = "https://8CD184CD97918C85E57A520CF226D9AC.gr7.us-east-1.eks.amazonaws.com"
  vpc_id             = dependency.vpc.outputs.vpc_id
  subnet_ids         = dependency.vpc.outputs.private_subnet_ids
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "eks" {
  config_path = "../eks"
}