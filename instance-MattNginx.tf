resource "aws_instance" "MattNginx" {
  ##  ami           = var.AMIS[var.AWS_REGION]
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mattkey.key_name
  # the VPC subnet
  subnet_id = aws_subnet.matt-pub-b.id
  # the security group
 ## vpc_security_group_ids = [aws_security_group.ssh-instance.id]
  tags = {
    Name = "MattNginx"
    Role = "Web"
  }
  provisioner "file" {
    source      = "Scripts/nginx.sh"
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

output "MattNginx" {
  value = aws_instance.MattNginx.public_ip
}
