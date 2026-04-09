output "state_bucket_name" {
  value       = aws_s3_bucket.terraform_state.id
  description = "Name of the S3 bucket for Terraform"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "DynamoDB table name for state locking"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "ARN of the bucket"
}