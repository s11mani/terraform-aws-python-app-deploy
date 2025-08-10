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
  public_key = file("./keys/id_rsa.pub")
  key_name   = "${var.project}-keypair"
  tags = {
    Name = "${var.project}-keypair"
  }
}

resource "aws_instance" "name" {
  ami           = "ami-0f918f7e67a3323f0"
  key_name      = aws_key_pair.name.key_name
  instance_type = "t2.micro"
  tags = {
    Name = "${var.project}-instance"
  }
  subnet_id                   = aws_subnet.name.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  associate_public_ip_address = true
  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("/terraform-prac/test/id_rsa")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "/terraform-prac/test/python-app/app.py"
    destination = "/home/ubuntu/app.py"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt-get install -y python3-pip",
      "sudo pip3 install flask",
      "nohup sudo python3 /home/ubuntu/app.py > /home/ubuntu/app.log 2>&1 &"
    ]
  }
}
