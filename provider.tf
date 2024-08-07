# Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket         = "s3-remote-backend-2024"
    key            = "aws-oraganization"
    region         = "us-west-2"
    encrypt        = true
  }
  
}

locals {
  default_tags = {
    "Department" = "DevOps"
    "ManagedBy"  = "Terraform"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.default_tags
  }
}

