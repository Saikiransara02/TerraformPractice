provider "aws" {
  region = "ap-south-1" # Mumbai region
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon official AMIs
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
}


#ami-0f1dcc636b69a6438
#ami-05ffdb220b574ff91
# custom ami 
provider "aws" {
  
}
#calling Default AMI process aas a Data source

# data "aws_ami" "amzlinux" {
#   most_recent = true
#   owners = [ "amazon" ]
#   filter {
#     name = "name"
#     values = [ "amzn2-ami-hvm-*-gp2" ]
#   }
#   filter {
#     name = "root-device-type"
#     values = [ "ebs" ]
#   }
#   filter {
#     name = "virtualization-type"
#     values = [ "hvm" ]
#   }
#   filter {
#     name = "architecture"
#     values = [ "x86_64" ]
#   }
# }

#Calling custom AMI process as data source

data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "self" ]
  filter {
    name = "name"
    values = [ "frontend-ami" ]
  }
  
}

resource "aws_instance" "dev" {
    ami = data.aws_ami.amzlinux.id
    instance_type = "t2.micro"
    tags = {
      Name = "dev"
    }


}