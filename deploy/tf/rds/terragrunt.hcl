terraform {
  source = "tfr:///terraform-aws-modules/rds/aws?version=5.0.0"
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
  rds_name           = "mx-bank-service"
  rds_engine         = "aurora-postgresql"
  rds_engine_version = "14.5"
  rds_instance_class = "db.serverless"
  vpc_id             = dependency.vpc.outputs.vpc_id
  subnet_ids         = dependency.vpc.outputs.private_subnet_ids
  master_username    = "mx_bank_service"
  master_password    = "adm1n#1234"

  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = dependency.vpc.outputs.private_subnet_cidrs
    }
  }

  serverlessv2_scaling_configuration = {
    min_capacity = 2
    max_capacity = 10
  }

  instance_class = "db.serverless"
  instances = {
    one = {}
    two = {}
  }
}

dependency "vpc" {
  config_path = "../vpc"
}