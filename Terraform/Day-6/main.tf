resource "aws_instance" "Import" {
   ami = "ami-0f1dcc636b69a6438" 
   instance_type = "t2.medium"
   tags = {
    Name = "Manualserver"
   }
}

#below examples are for lifecycle meta_arguments 
