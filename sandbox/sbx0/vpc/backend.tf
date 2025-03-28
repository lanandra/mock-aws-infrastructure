###########################
# Terraform Configuration #
###########################

terraform {
  backend "s3" {
    bucket       = "my-tfbucket"
    key          = "path/to/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }

  required_version = ">= 1.7.0"
}

provider "aws" {
  region = "ap-southeast-1"
}
