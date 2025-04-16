provider "aws" {
  
}

resource "aws_instance" "SSK" {
    ami = "ami-002f6e91abff6eb96"
    instance_type = "t2.micro"
    key_name = "Terraformkey"
}