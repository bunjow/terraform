output "defaultNginxIPS" {
  value = aws_instance.defaultNginx.public_ip
}

output "defaultNginxARN" {
  value = aws_instance.defaultNginx.arn
}

output "MattApacheIPS" {
  value = aws_instance.MattApache.public_ip
}

output "MattApacheARN" {
  value = aws_instance.MattApache.arn
}

