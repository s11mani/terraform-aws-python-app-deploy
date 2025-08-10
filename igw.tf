resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "${var.project}-igw"
  }
  depends_on = [aws_vpc.name]
}


