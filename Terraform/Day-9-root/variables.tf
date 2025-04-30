variable "ami_id" {
  description = "AMI value"
  type = string
  default = ""
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

# variable "bucket_name" {
#   description = "S3 Bucket name"
#   type        = string
# }