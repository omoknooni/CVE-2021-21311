resource "aws_vpc" "demo_vpc" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "tf-study"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "tf-study"
  }
}

resource "aws_subnet" "tf_study_subnet" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-study"
  }
}

resource "aws_route_table" "tf_study_public_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "tf-study"
  }
}

resource "aws_route" "tf_study_public_rt" {
  route_table_id = aws_route_table.tf_study_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.tf-igw.id
}

resource "aws_route_table_association" "tf_study_rt_asso" {
  subnet_id = aws_subnet.tf_study_subnet.id
  route_table_id = aws_route_table.tf_study_public_rt.id
}