resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST" # Pay-as-you-go
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S" # String
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Project     = var.project_name
  }
}