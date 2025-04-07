resource "aws_instance" "SSK" {
    ami = var.ami
    instance_type = var.instance_type
}
