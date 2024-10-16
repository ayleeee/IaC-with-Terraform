provider "aws" {
  region = "ap-northeast-2"  # 원하는 AWS 리전으로 변경
}

# EC2용 IAM 역할 프로파일
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}

# Ubuntu AMI 정보 가져오기
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]  # Ubuntu AMI의 공식 AWS 소유자 ID
}

# 기본 서브넷 가져오기
data "aws_subnet" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
  availability_zone = "ap-northeast-2a"  # 원하는 가용 영역
}

# 기본 보안 그룹 가져오기
data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
  vpc_id = data.aws_subnet.default.vpc_id
}

# EC2 인스턴스 생성
resource "aws_instance" "instanceName" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"  
  key_name                    = "key_name" 
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  vpc_security_group_ids      = [data.aws_security_group.default.id]  
  subnet_id                   = data.aws_subnet.default.id

  # EC2 인스턴스에 태그로 이름 부여
  tags = {
    Name = "instanceName"
  }
}

# EC2 인스턴스의 공인 IP 출력
output "instance_public_ip" {
  value = aws_instance.[instanceName].public_ip
}