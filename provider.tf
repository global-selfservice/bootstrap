provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket         = "self-service-dev-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
