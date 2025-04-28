resource "aws_instance" "prod" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.prod.id
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    associate_public_ip_address = true
    tags = {
      Name = "SSK"
    }
}