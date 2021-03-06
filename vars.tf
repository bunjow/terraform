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

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "PATH_TO_MATT_PRIVATE_KEY" {
  default = "mattkey"
}
variable "PATH_TO_MATT_PUBLIC_KEY" {
  default = "mattkey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "tags" {
  default = {
    "owner"   = "matt"
    "project" = "study"
    "client"  = "Internal"
  }
}

variable "matt_vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "ssh_inbound" {
  type        = list
  description = "list of my possible IP addresses from home"
}

variable "http_inbound" {
  type        = list
  description = "list of http inbound cidr"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "RDS_PASSWORD" {
  default = "password"
}

variable "server_port" {
  default = "80"
}

variable "ports" {
  type = map(list(string))
  default = {
    "22"  = ["104.140.53.67/32", "107.173.59.69/32", "173.232.242.20/32", "192.227.211.172/32"]
    "443" = ["0.0.0.0/0"]
    "80"  = ["0.0.0.0/0"]

  }
}