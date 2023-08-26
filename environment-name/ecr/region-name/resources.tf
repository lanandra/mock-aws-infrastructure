####################
# ECR Repositories #
####################

module "my_repository" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  repository_name             = "my-repository"
  repository_lifecycle_policy = file("${path.module}/files/policies/expire-untagged-images.json")

  tags = {
    Name             = "my-repository"
    "my:environment" = "my-environment"
  }
}
