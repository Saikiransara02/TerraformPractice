resource "aws_instance" "this" {
  ami           = "ami-0f1dcc636b69a6438"  # Replace with a valid AMI
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-ssk"
  }
}