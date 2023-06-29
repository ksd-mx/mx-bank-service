terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.0.0"
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
  name            = "${include.env.locals.env}-mx-bank-service-vpc"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public_subnets  = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]
}