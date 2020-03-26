variable "AWS_SHARED_CREDENTIALS_FILE" {
}

variable "AWS_PROFILE" {
}

variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0fc20dd1da406780b"
    us-east-2 = "ami-0fc20dd1da406780b"
  }
}

