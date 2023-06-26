variable "env" {
  description = "Environment name."
  type        = string
}

variable "api_name" {
  description = "Name of the API gatew"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs across a minimum of 2 azs."
  type        = list(string)
}