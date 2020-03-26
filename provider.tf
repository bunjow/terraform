provider "aws" {
  region     = var.AWS_REGION
  shared_credentials_file = var.AWS_SHARED_CREDENTIALS_FILE
  profile                 = var.AWS_PROFILE
  region                  = var.AWS_REGION
}

