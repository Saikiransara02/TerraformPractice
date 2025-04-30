resource "aws_instance" "SSK" {
    ami = var.aami_id
    instance_type = var.instance_type
}