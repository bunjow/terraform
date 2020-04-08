output "exampleIPS" {
  value = aws_instance.example.public_ip
}

output "exampeARN" {
  value = aws_instance.example.arn
}

output "MattInstanceIPS" {
  value = aws_instance.MattInstance.public_ip
}

output "MattInstanceARN" {
  value = aws_instance.MattInstance.arn
}

