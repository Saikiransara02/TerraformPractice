output "AZ" {
    value = aws_instance.name.availability_zone

}

output "PublicIp" {
    value = aws_instance.name.public_ip
  
}

output "privateIp" {
    value = aws_instance.name.private_ip
    sensitive = true
  
}