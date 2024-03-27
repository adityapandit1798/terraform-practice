terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
// this is a test comment
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


