terraform {
  backend "s3" {
    bucket         = "otms-dev-state-sprint-05"
    key            = "dev/db/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}