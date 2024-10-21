# 첫 번째 서브넷의 CIDR 블록 변수 선언
variable "web-subnet1-cidr" {
  description = "첫 번째 서브넷의 CIDR 블록"
  type        = string
  default     = "10.0.10.0/24" 
}

# 두 번째 서브넷의 CIDR 블록 변수 선언
variable "web-subnet2-cidr" {
  description = "두 번째 서브넷의 CIDR 블록"
  type        = string
  default     = "10.0.20.0/24" 
}

# 첫 번째 서브넷 (web-subnet1) 생성
resource "aws_subnet" "web-subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.web-subnet1-cidr
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet1"
  }
}

# 두 번째 서브넷 (web-subnet2) 생성
resource "aws_subnet" "web-subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.web-subnet2-cidr
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "my-subnet2"
  }
}
