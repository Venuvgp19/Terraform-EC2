##Creating user defined VPC

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "main"
  }
}


##Adding Subnets
resource "aws_subnet" "Public-Subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Public-Subnet1"
  }
}

#Adding private subnet 

resource "aws_subnet" "Private-Subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "Private-Subnet1"
  }
}

##Adding IGW

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#Adding route tables

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "route_table"
  }
}

##Routetable association

resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.Public-Subnet1.id
  route_table_id = aws_route_table.route_table.id
}
