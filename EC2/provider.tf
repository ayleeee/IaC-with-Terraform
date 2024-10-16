# EC2 생성에 필요한 IAM 역할 생성
resource "aws_iam_role" "ec2_instance_role" {
  name = "ec2-instance-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# EC2 인스턴스를 위한 정책 정의 (필요한 경우 다른 정책 추가 가능)
resource "aws_iam_policy" "ec2_basic_policy" {
  name        = "ec2-basic-policy"
  description = "Basic permissions for managing EC2 instances"
  
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeInstances",   # EC2 인스턴스 조회 권한
          "ec2:RunInstances",        # EC2 인스턴스 실행 권한
          "ec2:TerminateInstances",  # EC2 인스턴스 종료 권한
          "ec2:StartInstances",      # EC2 인스턴스 시작 권한
          "ec2:StopInstances"        # EC2 인스턴스 중지 권한
        ],
        "Resource": "*"
      }
    ]
  })
}

# IAM 역할에 EC2 정책 연결
resource "aws_iam_role_policy_attachment" "attach_ec2_policy" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.ec2_basic_policy.arn
}
