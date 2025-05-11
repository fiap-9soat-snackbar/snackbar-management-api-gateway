terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "snackbar-management-10-05-2025"
    key    = "api-gateway/terraform.tfstate"
  }
}

#data "terraform_remote_state" "global" {
#  backend = "s3"
#  config = {
#    region = "us-east-1"
#    bucket = "snackbar-management-10-05-2025"
#    key    = "global/terraform.tfstate"
#  }
#}

data "terraform_remote_state" "lambda" {
  backend = "s3"
  config = {
    region = "us-east-1"
    bucket = "snackbar-management-10-05-2025"
    key    = "functions/lambda/terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}
