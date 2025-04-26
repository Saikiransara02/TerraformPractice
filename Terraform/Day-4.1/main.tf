provider "aws" {
  
}

resource "aws_instance" "name" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    key_name = "Terraformkey"
    tags = {
      Name = "devssk"
    }
   
}