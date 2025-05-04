# Create key pair
resource "aws_key_pair" "example" {
  key_name   = "taskk"  # Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub")
}

# # IAM Policy for S3 access
# resource "aws_iam_policy" "s3_access_policy" {
#   name        = "EC2S3AccessPolicy"
#   description = "Policy for EC2 instances to access S3"
#   policy      = jsonencode({
#     Version   = "2012-10-17"
#     Statement = [
#       {
#         Action   = [
#           "s3:PutObject",
#           "s3:GetObject",
#           "s3:ListBucket"
#         ]
#         Effect   = "Allow"
#         Resource = [
#           "arn:aws:s3:::multicloudnareshitveera",
#           "arn:aws:s3:::multicloudnareshitveera/*"
#         ]
#       }
#     ]
#   })
# }

# # IAM Role for EC2
# resource "aws_iam_role" "ec2_role" {
#   name = "ec2_s3_access_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Effect    = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#   })
# }

# # Attach policy to role
# resource "aws_iam_role_policy_attachment" "ec2_role_attachment" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = aws_iam_policy.s3_access_policy.arn
# }

# # Create an instance profile for the role
# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "ec2_s3_access_instance_profile"
#   role = aws_iam_role.ec2_role.name

# }
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # replace with your IP
  }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# EC2 instance with IAM instance profile attached
resource "aws_instance" "web_server" {
  ami                  = "ami-0f88e80871fd81e91" # Update with a valid AMI ID
  instance_type        = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name             = aws_key_pair.example.key_name
  associate_public_ip_address = true
  #security_groups      = ["default"]
  #iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  #availability_zone = "us-east-1a"

  tags = {
    Name = "MyWebServer"
  }
}

# Null resource to run remote commands on the instance
resource "null_resource" "setup_and_upload" {
  depends_on = [aws_instance.web_server]

  provisioner "remote-exec" {
    inline = [
      # Install Apache if not installed
      "sudo yum install -y httpd",
      
      # Start Apache
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",

      # Ensure /var/www/html/ directory exists
      "sudo mkdir -p /var/www/html/",

      # Create a sample index.html file
      "echo '<h1>Welcome to My Web Server</h1>' | sudo tee /var/www/html/index.html",

      # Upload the file to S3
      #"aws s3 cp /var/www/html/index.html s3://multicloudnareshitveera/",
      #"echo 'File uploaded to S3'"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web_server.public_ip
  }

  triggers = {
    instance_id = aws_instance.web_server.id
  }
}