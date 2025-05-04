# locals {
#   bucket-name = "${var.layer}-${var.env}-bucket-hydnard"
#   env = "dev"
#   type = "web"
# }

# resource "aws_s3_bucket" "demo" {
#     # bucket = "web-test-bucket-hydnaresh"
#     # bucket = "${var.layer}-${var.env}-bucket-hyd"
#     bucket = local.bucket-name
#     tags = {
#         # Name = "${var.layer}-${var.env}-bucket-hyd"
#         Name = local.type
#         Environment = local.env
#     }
    
 
  
# }


############ Ex:2
provider "aws" {
  
}
locals {
  region = "us-east-1"
  environment = "dev"
  instance_type = "t2.micro"
  ami = "ami-0c55b159cbfafe1f0"
  Name = var.name
}

resource "aws_instance" "example" {
  ami           = local.ami # Amazon Linux 2 AMI
  instance_type = local.instance_type

  tags = {
    Name        = local.Name
    Environment = local.environment
  }
}