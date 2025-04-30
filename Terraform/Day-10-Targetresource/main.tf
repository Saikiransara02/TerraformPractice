resource "aws_instance" "dependent" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    #key_name = "public"
}

resource "aws_s3_bucket" "dependent" {
    bucket = "sskbucket1111" 
}

#terraform apply -target=aws_s3_bucket.dependent
#terraform destroy -target=aws_s3_bucket.dependent

#Example below for multiple targets
#terraform apply -target=aws_s3_bucket.dependent -target=aws_instance.dev -target=aws_db_instance.database