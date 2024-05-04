resource "aws_vpc" "vpc" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "new_VPC"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "InternetGateway"
    }
}

resource "aws_eip" "nat_eip" {
    vpc    = true
    region = "us-east-1"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.public_subnet.id

    depends_on = [aws_eip.nat_eip]
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "us-east-1a"

    tags = {
        Name = "public-subnet"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "public_route"
    }
}

resource "aws_route" "public_route" {
    route_table_id         = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "private-subnet"
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "private_route"
    }
}

resource "aws_route" "private_route" {
    route_table_id         = aws_route_table.private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_subnet_association" {
    subnet_id      = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_subnet" "private_subnet1" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1c"

    tags = {
        Name = "private-subnet1"
    }
}

resource "aws_route_table" "private_route_table1" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "private_route1"
    }
}

resource "aws_route_table_association" "private_subnet_association1" {
    subnet_id      = aws_subnet.private_subnet1.id
    route_table_id = aws_route_table.private_route_table1.id
}
