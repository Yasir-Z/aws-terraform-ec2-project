#This is variable file

variable "aws_region" {
    default = "us-east-1"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "cidr_block" {
    default = "0.0.0.0/0"
}

