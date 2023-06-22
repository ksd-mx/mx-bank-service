variable "env" {
  description = "Environment name."
  type        = string
}

variable "rds_name" {
  description = "Name of the rds cluster."
  type        = string
}

variable "rds_engine" {
  description = "Name of the rds engine."
  type        = string
}

variable "rds_instance_class" {
  description = "Name of the rds engine."
  type        = string
}

variable "rds_engine_version" {
  description = "Name of the rds engine version."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC this cluster will belong to."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs across a minimum of 2 azs."
  type        = list(string)
}

variable "master_username" {
  description = "Name of the master DB user."
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user."
  type        = string
}

variable "rds_iam_policies" {
  description = "List of IAM policies to attach to the node role."
  type        = list(string)
  default     = null
}

variable "security_group_rules" {
  description = "Map of security group rules to add to the cluster security group created"
  type        = any
  default     = {}
}

variable "serverlessv2_scaling_configuration" {
  description = "Map of nested attributes with serverless v2 scaling properties. Only valid when `engine_mode` is set to `provisioned`"
  type        = map(string)
  default     = {}
}