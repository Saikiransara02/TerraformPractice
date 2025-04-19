terraform {
  backend "s3" {
    bucket = "ssk1997"
    key = "terraform.tfstate"
    region = "ap-south-1"

  }
}