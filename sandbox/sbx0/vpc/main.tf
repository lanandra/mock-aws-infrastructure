#######
# VPC #
#######


data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    "environment" = "${var.env_name}"
    "managedBy"   = "terraform"
  }
}

module "sbx0_apse1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = var.env_name
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 3)]

  enable_nat_gateway = false
  single_nat_gateway = true

  tags = local.tags
}
