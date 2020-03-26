terraform {
  backend "s3" {
    bucket = "terraform-state-meng0303"
    key    = "terraform/bunjow"
  }
}
