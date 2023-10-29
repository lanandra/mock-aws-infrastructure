#######
# VPC #
#######


data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    "myTag:environment" = "sandbox"
    "myTag:managedBy"   = "terraform"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.env_name
  cidr = "10.255.8.0/21"

  azs             = local.azs
  private_subnets = ["10.255.8.0/24", "10.255.9.0/24", "10.255.10.0/24"]
  public_subnets  = ["10.255.15.0/24", "10.255.14.0/24", "10.255.13.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.tags
}
