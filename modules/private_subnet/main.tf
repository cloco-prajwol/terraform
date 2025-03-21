resource "aws_subnet" "private_subnet" {
  vpc_id                  = var.vpc
  map_public_ip_on_launch = false
  cidr_block              =  cidrsubnet(var.vpc_cidr, 4, 5)
    availability_zone_id    = var.availability_zones

  tags = {
    Name = "${var.prefix}-private-subnet"
  }
}
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc
  tags = {
    Name = "${var.prefix}-private-route-table"
  }
}


resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
