#############
# IAM Users #
#############

module "tf_assume_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.9.2"

  name                          = "tf-assume-user"
  force_destroy                 = true
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  tags = {
    Name             = "tf-assume-user"
    "my:environment" = "my-environment"
  }
}

##############
# IAM Groups #
##############

module "tf_assume_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.9.2"

  name                              = "tf-assume-group"
  attach_iam_self_management_policy = false

  group_users = [
    module.tf_assume_user.iam_user_name
  ]

  custom_group_policy_arns = [
  ]

  tags = {
    Name             = "tf-assume-group"
    "my:environment" = "my-environment"
  }
}

#############
# IAM Roles #
#############

module "compute_admin_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.11.1"

  trusted_role_arns = [
    "arn:aws:iam::12digitsawsid:user/tf-assume-user",
  ]

  trusted_role_services = [
    "lightsail.amazonaws.com"
  ]

  create_role       = true
  role_name_prefix  = "compute-admin-sbx"
  role_requires_mfa = false

  custom_role_policy_arns = [
    module.lightsail_full_access.arn
  ]
}

################
# IAM Policies #
################

module "lightsail_full_access" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.11.1"

  name        = "lightsail-full-access"
  path        = "/"
  description = "Provides full access to Amazon Lightsail"
  policy      = file("${path.module}/files/policies/lightsail/lightsail-full-access.json")

  tags = {
    Name             = "lightsail-full-access"
    "my:environment" = "my-environment"
  }
}
