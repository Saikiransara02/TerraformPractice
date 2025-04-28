#creating vpc
resource "aws_vpc" "prod" {
    cidr_block = "1.0.0.0/16"
    tags = {
      Name = "Prod_vpc"
    }
  }

#creating subnet
resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "1.0.0.0/24"
    tags = {
      Name = "Prod_subnet"
    }
  
}

#creating private subnet
resource "aws_subnet" "prod_private" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "1.0.1.0/24"
    tags = {
      Name = "Private_subnet"
    }
  
}

#creating internet gateway
resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
      Name = "Prod_IG"
    }

}

#creating route table and edit route
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.prod.id

    route{
        gateway_id = aws_internet_gateway.prod.id
        cidr_block = "0.0.0.0/0"
    }
}

# subnet association
resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.name.id
    subnet_id = aws_subnet.prod.id
  
}

#creating security group
resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    description = "allow inbound rules"
    vpc_id = aws_vpc.prod.id

ingress{
    description = "inbound rules"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks =["0.0.0.0/0"]
}
  tags = {
    Name="security rule"
  }
}

