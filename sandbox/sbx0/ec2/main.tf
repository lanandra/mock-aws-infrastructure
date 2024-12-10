data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    "environment" = "${var.env_name}"
    "managedBy"   = "terraform"
  }
}

#######
# EC2 #
#######

# after import has been finished, please remove this import block
import {
  to = module.lab_import_tf.aws_instance.this[0]
  id = "i-083e2e6033b02ae8a" # change with id of your ec2 instance
}

module "lab_import_tf" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = "lab-import-tf" # change with name that used by your ec2 instance

  ami                         = "ami-0695dfe470b88c986" # change with ami id that used by your ec2 instance
  instance_type               = "t3a.nano"              # change with instance type that used by your ec2 instance
  availability_zone           = element(local.azs, 0)
  subnet_id                   = element(var.public_subnet_id, 0)
  vpc_security_group_ids      = [module.lab_sg.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.env_name
  iam_instance_profile        = module.lab_instance_profile.iam_instance_profile_name

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 10
      tags = merge(
        local.tags,
        {
          Name = "lab-import-tf"
        }
      )
    }
  ]

  tags = local.tags
}

##################
# Security Group #
##################

module "lab_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = "${var.env_name}-lab"
  description = "lab security group"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      cidr_blocks = var.default_route
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = var.default_route
    }
  ]

  egress_rules = var.egress_rules

  tags = local.tags
}

####################
# Instance Profile #
####################

module "lab_instance_profile" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.47.1"

  create_role             = true
  create_instance_profile = true

  role_name = "lab-instance-profile"

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  tags = local.tags
}
