resource "aws_instance" "SSK" {
    ami = var.ami_id
    instance_type = var.instance_type
}