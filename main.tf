provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "myproject_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myproject-vpc"
  }
}

resource "aws_subnet" "myproject_subnet_1" {
  vpc_id     = aws_vpc.myproject_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "myproject-subnet-1"
  }
}

resource "aws_subnet" "myproject_subnet_2" {
  vpc_id     = aws_vpc.myproject_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "myproject-subnet-2"
  }
}

resource "aws_subnet" "myproject_subnet_3" {
  vpc_id     = aws_vpc.myproject_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-central-1c"
  tags = {
    Name = "myproject-subnet-3"
  }
}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.myproject_vpc.id

  tags = {
    Name = "my-gateway"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.myproject_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gateway.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "my_association_1" {
  subnet_id      = aws_subnet.myproject_subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "my_association_2" {
  subnet_id      = aws_subnet.myproject_subnet_2.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "my_association_3" {
  subnet_id      = aws_subnet.myproject_subnet_3.id
  route_table_id = aws_route_table.my_route_table.id
}
