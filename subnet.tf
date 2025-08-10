resource "aws_subnet" "name" {
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  vpc_id            = aws_vpc.name.id
  tags = {
    Name = "${var.project}-subnet"
  }
}

