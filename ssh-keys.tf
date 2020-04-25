resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_key_pair" "mattkey" {
  key_name   = "mattkey"
  public_key = file(var.PATH_TO_MATT_PUBLIC_KEY)
}

