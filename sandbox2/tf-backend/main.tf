###########################
# Terraform Configuration #
###########################

terraform {
  backend "s3" {
    bucket         = "my-sandbox2-tfbucket"
    key            = "path/to/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "my-sandbox2-tflocks"
    encrypt        = true
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}
