# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "mx-bank-mx-terraform-backend-us-east-1-dev"
    dynamodb_table = "mx-bank-mx-terraform-backend-us-east-1-dev"
    encrypt        = true
    key            = "dev/vpc/terraform.tfstate"
    region         = "us-east-1"
  }
}
