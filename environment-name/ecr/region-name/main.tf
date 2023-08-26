###########################
# Terraform Configuration #
###########################

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "my-organization"

    workspaces {
      name = "my-ecr-workspace"
    }
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
