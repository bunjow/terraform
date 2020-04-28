terraform {
  backend "s3" {
    bucket = "matt-state-meng0303"
    key    = "terraform/bunjow"
    region = "us-east-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "matt-terraform-lock"
    encrypt        = true
  }
}
