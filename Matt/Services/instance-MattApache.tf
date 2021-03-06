resource "aws_instance" "MattApache" {
  #  ami           = var.AMIS[var.AWS_REGION]
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mattkey.key_name
  subnet_id     = aws_subnet.matt-pub-a.id
  # Apply role here. Example: s3 bucket:
  # iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name
  tags = {
    Name = "MattApache"
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
################################
#  Add EBS storage /dev/xvdh
###############################
##resource "aws_ebs_volume" "ebs-volume-1" {
##  availability_zone = "us-east-2a"
##  size              = 20
##  type              = "gp2"
##  tags = {
##    Name = "extra volume data"
##  }
##}
##resource "aws_volume_attachment" "ebs-volume-1-attachment" {
##  device_name = "/dev/xvdh"
##  volume_id   = aws_ebs_volume.ebs-volume-1.id
##  instance_id = aws_instance.MattApache.id
##}

output "MattApacheIP" {
  value = aws_instance.MattApache.public_ip
}
