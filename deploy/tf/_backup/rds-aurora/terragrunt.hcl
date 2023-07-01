terraform {
  source = "tfr:///terraform-aws-modules/rds-aurora/aws?version=8.3.1"
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
  name            = "${local.prefix}-db"
  engine          = "aurora-postgresql"
  engine_mode     = "provisioned"
  engine_version  = "14.5"
  master_username = "root"

  vpc_id  = dependency.vpc.outputs.vpc_id
  subnets = dependency.vpc.outputs.private_subnets

  create_db_subnet_group = true

  db_subnet_group_name = "${local.prefix}-db-subnet-group"

  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = dependency.vpc.outputs.private_subnets_cidr_blocks
    }
  }

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  serverlessv2_scaling_configuration = {
    min_capacity = 2
    max_capacity = 10
  }

  instance_type  = "db.serverless"
  instance_class = "db.serverless"
  instances = {
    one = {}
    two = {}
  }
}

dependency "vpc" {
  config_path = "../vpc"
}