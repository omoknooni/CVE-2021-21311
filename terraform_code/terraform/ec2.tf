# 인스턴스 접속용 키페어
resource "aws_key_pair" "vuln_service" {
    key_name = "vuln_service"
    public_key = file("./vuln_service.pub")
}

# 인스턴스에 Role 연결
resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.vuln_role.name
}

# 인스턴스의 security group, ingress에 접근할 ip(인바운드)를 설정
resource "aws_security_group" "tf_vulnweb_sg" {
    name = "tf_vulnweb_sg"
    description = "web port"
    vpc_id = aws_vpc.demo_vpc.id
    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 80
      to_port = 80
      protocol = "tcp"
    }

    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    egress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 0
      protocol = "-1"
      description = "outbound"
    }
}

# 취약한 인스턴스 상세
resource "aws_instance" "tf_instance" {
  ami = "ami-0e9bfdb247cc8de84"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2-instance-profile.name
  key_name = aws_key_pair.vuln_service.key_name
  vpc_security_group_ids = [
    aws_security_group.tf_vulnweb_sg.id
  ]
  subnet_id = aws_subnet.tf_study_subnet.id
  associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y wget git apache2 php
wget https://github.com/vrana/adminer/releases/download/v4.7.8/adminer-4.7.8.php
mv adminer-4.7.8.php /var/www/html/index.php
rm /var/www/html/index.html
  EOF
  tags = {
    Name = "ssrf_vuln_web"
  }
  depends_on = ["aws_internet_gateway.tf-igw"]
}

output "public_ip" {
  value = aws_instance.tf_instance.public_ip
}