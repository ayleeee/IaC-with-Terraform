provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "my_ec2" {
  # 아마존 리눅스 2
  ami           = "ami-034a31ed1d34ef024" 
  instance_type = "t2.micro"
  key_name = "keyname"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id = aws_subnet.web-subnet1.id

  root_block_device {
    volume_type = "gp2"   
    volume_size = 8       
  }

  user_data = <<EOF
#!/bin/sh
        
# Install a LAMP stack
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum -y install httpd php-mbstring
sudo yum -y install git
        
# Start the web server
sudo chkconfig httpd on
sudo systemctl start httpd
        
# Install the web pages for our lab
if [ ! -f /var/www/html/aws-boarding-pass-webapp.tar.gz ]; then
    cd /var/www/html
    wget -O 'techcamp-webapp-2024.zip' 'https://ws-assets-prod-iad-r-icn-ced060f0d38bc0b0.s3.ap-northeast-2.amazonaws.com/600420b7-5c4c-498f-9b80-bc7798963ba3/techcamp-webapp-2024.zip'
    unzip techcamp-webapp-2024.zip
    sudo mv techcamp-webapp-2024/* .
    sudo rm -rf techcamp-webapp-2024
    sudo rm -rf techcamp-webapp-2024.zip
fi
        
# Install the AWS SDK for PHP
if [ ! -f /var/www/html/aws.zip ]; then
    cd /var/www/html
    sudo mkdir vendor
    cd vendor
    sudo wget https://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.zip
    sudo unzip aws.zip
fi
        
# Update existing packages
sudo yum -y update
EOF

  tags = {
    Name = "my-webserver-01"
  }
}

resource "aws_instance" "my_ec2-2" {
  ami           = "ami-034a31ed1d34ef024" 
  instance_type = "t2.micro"
  key_name = "keyname"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id = aws_subnet.web-subnet2.id

  root_block_device {
    volume_type = "gp2"   
    volume_size = 8      
  }

  user_data = <<EOF
#!/bin/sh
        
# Install a LAMP stack
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum -y install httpd php-mbstring
sudo yum -y install git
        
# Start the web server
sudo chkconfig httpd on
sudo systemctl start httpd
        
# Install the web pages for our lab
if [ ! -f /var/www/html/aws-boarding-pass-webapp.tar.gz ]; then
    cd /var/www/html
    wget -O 'techcamp-webapp-2024.zip' 'https://ws-assets-prod-iad-r-icn-ced060f0d38bc0b0.s3.ap-northeast-2.amazonaws.com/600420b7-5c4c-498f-9b80-bc7798963ba3/techcamp-webapp-2024.zip'
    unzip techcamp-webapp-2024.zip
    sudo mv techcamp-webapp-2024/* .
    sudo rm -rf techcamp-webapp-2024
    sudo rm -rf techcamp-webapp-2024.zip
fi
        
# Install the AWS SDK for PHP
if [ ! -f /var/www/html/aws.zip ]; then
    cd /var/www/html
    sudo mkdir vendor
    cd vendor
    sudo wget https://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.zip
    sudo unzip aws.zip
fi
        
# Update existing packages
sudo yum -y update
EOF

  tags = {
    Name = "my-webserver-02"
  }
}

output "instance_id" {
  value = aws_instance.my_ec2-2.id
}

output "public_ip" {
  value = aws_instance.my_ec2-2.public_ip
}

output "instance_type" {
  value = aws_instance.my_ec2-2.instance_type
}
