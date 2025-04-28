resource "aws_instance" "name" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    key_name = "Terraformkey"
    tags = {
      Name = "devssk"
    }
#below examples are for lifecycle meta_arguments 

   lifecycle {
    create_before_destroy = true
    ignore_changes = [tags,]    #this attribute will create the new object first and then destroy the old one
   }
}
