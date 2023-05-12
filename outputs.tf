output "komiser" {
  value = "https://${aws_route53_record.komiser.name}"
}

output "IP_Address" {
  value = aws_instance.komiser.public_ip
}