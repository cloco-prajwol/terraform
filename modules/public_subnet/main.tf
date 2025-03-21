resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 1)
  map_public_ip_on_launch = true
  availability_zone_id    = var.availability_zones
  tags = {
    Name = "${var.prefix}-public-subnet"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc
  tags = {
    Name = "${var.prefix}-public-route-table"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
