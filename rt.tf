resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "${var.project}-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}

resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.name.id
  subnet_id      = aws_subnet.name.id
}
