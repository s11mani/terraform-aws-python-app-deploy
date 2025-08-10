resource "aws_security_group" "name" {
  name        = "${var.project}-sg"
  description = "${var.project}-sg"
  tags = {
    Name = "${var.project}-sg"
  }
  vpc_id = aws_vpc.name.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "ssh access"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8096
    to_port     = 8096
    protocol    = "tcp"
    description = "application access"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    description = "all traffic outbound"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "name" {
  public_key = file("/terraform-prac/test/id_rsa.pub")
  key_name   = "${var.project}-keypair"
  tags = {
    Name = "${var.project}-keypair"
  }
}
