terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }

  # Demo-scale project: state is local on purpose. At real fleet scale this
  # would move to a remote backend (S3 + DynamoDB lock table) - see README
  # "at 1000x scale" section for why that matters once more than one person
  # or CI runner touches this state.
  # backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}
