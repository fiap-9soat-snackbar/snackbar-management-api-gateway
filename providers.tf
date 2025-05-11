terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # S3 backend configuration is in backend.tf
}

provider "aws" {
  region = local.region
}
