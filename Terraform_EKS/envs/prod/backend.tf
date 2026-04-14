terraform {
  backend "s3" {
    bucket         = "allegro-analytics-eks-tfstate-2026"
    key            = "envs/prod/eks/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
