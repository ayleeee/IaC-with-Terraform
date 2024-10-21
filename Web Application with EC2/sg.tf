resource "aws_security_group" "security_group"{
    vpc_id = aws_vpc.vpc.id
    description = "security group for web servers"
    tags = {
        Name = "my-web-sg"
    }
    
    ingress {
        description = "Allow SSH from my IP"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =[""]
    }

    ingress {
        description = "Allow HTTP from my IP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks =[""]
    }

    egress {
    from_port        = 0
    to_port          = 0
    # 모든 프로토콜
    protocol         = "-1"  
    cidr_blocks      = ["0.0.0.0/0"]
  }

}