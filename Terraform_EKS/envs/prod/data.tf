data "aws_secretsmanager_secret" "manual_secrets" {
  name = var.secrets_name
}
