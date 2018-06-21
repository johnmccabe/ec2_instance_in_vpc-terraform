# Define our VPC
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name       = "tf-vpc-instance"
    created_by = "john.mccabe@puppet.com"
    department = "engineering"
    project    = "incubator-tfcomparison"
    lifetime   = "1h"
  }
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_cidr}"

  tags {
    Name       = "tf-vpc-instance"
    created_by = "john.mccabe@puppet.com"
    department = "engineering"
    project    = "incubator-tfcomparison"
    lifetime   = "1h"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name       = "tf-vpc-instance"
    created_by = "john.mccabe@puppet.com"
    department = "engineering"
    project    = "incubator-tfcomparison"
    lifetime   = "1h"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name       = "tf-vpc-instance"
    created_by = "john.mccabe@puppet.com"
    department = "engineering"
    project    = "incubator-tfcomparison"
    lifetime   = "1h"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Define the security group for public subnet
resource "aws_security_group" "sgweb" {
  name        = "vpc_test"
  description = "Allow incoming connections"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name       = "tf-vpc-instance"
    created_by = "john.mccabe@puppet.com"
    department = "engineering"
    project    = "incubator-tfcomparison"
    lifetime   = "1h"
  }
}
