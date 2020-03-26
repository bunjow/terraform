terraform {
  backend "s3" {
    bucket = "terraform-state-meng0303a"
    key    = "terraform/demo4"
  }
}
