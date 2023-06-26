remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    bucket         = "mx-bank-mx-terraform-backend-us-east-1-dev"
    dynamodb_table = "mx-bank-mx-terraform-backend-us-east-1-dev"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
    provider "aws" {
        region = "us-east-1"
        assume_role {
          role_arn = "arn:aws:iam::324654522070:role/terraform-deployment-role"
        }
    }
    EOF
}