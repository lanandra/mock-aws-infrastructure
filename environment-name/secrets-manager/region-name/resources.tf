###########
# Secrets #
###########

resource "aws_secretsmanager_secret" "my_machine_secret" {
  name                    = "my-machine-secret"
  recovery_window_in_days = var.waiting_deletion_period

  tags = {
    "Name"           = "my-machine-secret"
    "my:environment" = "my-environment-name"
    "my:owner"       = "my-owner-name"
  }
}

resource "aws_secretsmanager_secret_version" "my_machine_secret" {
  secret_id     = aws_secretsmanager_secret.my_machine_secret.id
  secret_string = jsonencode(var.my_machine_credentials)
}
