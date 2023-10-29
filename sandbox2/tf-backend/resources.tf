######
# S3 #
######

resource "aws_s3_bucket" "my_sandbox2_tfbucket" {
  bucket = "my-sandbox2-tfbucket"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "my_sandbox2_tfbucket" {
  bucket = aws_s3_bucket.my_sandbox2_tfbucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_sandbox2_tfbucket" {
  bucket = aws_s3_bucket.my_sandbox2_tfbucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "my_sandbox2_tfbucket" {
  bucket                  = aws_s3_bucket.my_sandbox2_tfbucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

############
# DynamoDB #
############

resource "aws_dynamodb_table" "my_sandbox2_tflocks" {
  name         = "my-sandbox2-tflocks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

#######
# IAM #
#######

data "aws_iam_policy_document" "codecatalyst_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "codecatalyst.amazonaws.com",
        "codecatalyst-runner.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "codecatalyst_admin" {
  name               = "codecatalyst-admin"
  assume_role_policy = data.aws_iam_policy_document.codecatalyst_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "codecatalyst_admin" {
  role       = aws_iam_role.codecatalyst_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
