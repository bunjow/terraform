resource "aws_key_pair" "mattkey" {
  key_name   = "mattkey"
  public_key = file(var.PATH_TO_MATT_PUBLIC_KEY)
}

resource "aws_instance" "MattApache" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mattkey.key_name
  subnet_id     = aws_subnet.matt-pub-a.id
  tags = {
    Name = "MattWeb"
    Role = "Web"
  }

  provisioner "file" {
    source      = "Scripts/apache.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_MATT_PRIVATE_KEY)
  }
}
