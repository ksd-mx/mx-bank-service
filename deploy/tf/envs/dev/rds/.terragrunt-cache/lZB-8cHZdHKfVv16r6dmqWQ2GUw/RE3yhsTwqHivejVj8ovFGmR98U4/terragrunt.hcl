terraform {
  source = "../../../modules/rds"
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
  env         = include.env.locals.env
  rds_name    = "mx-bank-service"
  rds_engine  = "aurora-postgresql"
  rds_engine_version = "14.5"
  rds_instance_class   = "db.serverkess"
  vpc_id      = dependency.vpc.outputs.vpc_id
  subnet_ids  = dependency.vpc.outputs.private_subnet_ids
  master_username = "admin"
  master_password = "adm1n#1234"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnet_ids = ["subnet-1234567890", "subnet-1234567890", "subnet-1234567890"]
  }
}