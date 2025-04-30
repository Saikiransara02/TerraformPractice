provider "aws" {
  #region = "us-east-1"
}



module "ec2_instance" {
  source        = "./Module/ec2"
  ami_id = "ami-0f1dcc636b69a6438"
  instance_type = "t2.micro"
}

# module "s3_bucket" {
#   source      = "./modules/s3"
#   bucket_name = "my-terraform-bucket-12345"
# }