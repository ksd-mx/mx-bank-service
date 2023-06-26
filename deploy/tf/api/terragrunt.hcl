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
  vpc_id             = dependency.vpc.outputs.vpc_id
  subnet_ids         = dependency.vpc.outputs.private_subnet_ids
}

dependency "vpc" {
  config_path = "../vpc"
}