variable "vpc-cidr-block" {
  description = "VPC의 CIDR 블록"
  type        = string
  default     = "10.0.0.0/16" 
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block
  
  tags = {
    Name = "my-vpc-name"
  }
}