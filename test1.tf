terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.region
}
variable "region" {default = "us-east-1"}

#VPC1
variable "vpc1_cidr" {default = "10.0.0.0/16"}
resource "aws_vpc" "VPC1" {
  cidr_block = var.vpc1_cidr
}

#get vpc id from VPC1
output "vpc1_id" {value = aws_vpc.VPC1.id}


#subnet ----- create subnet inside above created vpc
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.VPC1.id
  cidr_block        = cidrsubnet(aws_vpc.VPC1.cidr_block, 4, 1)
  availability_zone = "us-east-1"
}

#create ec2
# Get the latest Amazon Linux 2 AMI ID
data "aws_ami" "linux-ami1" {
  most_recent = true
  filter {
    name   = "name" // filter amis by name property
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  }
#ec2
resource "aws_instance" "server-1" {
  ami           = data.aws_ami.linux-ami1.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  key_name = "Key1"
  security_groups = [ "All-traffic" ]
}
