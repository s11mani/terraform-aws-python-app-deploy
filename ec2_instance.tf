resource "aws_instance" "name" {
  ami           = var.ami
  key_name      = aws_key_pair.name.key_name
  instance_type = var.instance_type
  tags = {
    Name = "${var.project}-instance"
  }
  subnet_id                   = aws_subnet.name.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  associate_public_ip_address = true
  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("./keys/id_rsa")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "./python-app/app.py"
    destination = "/home/ubuntu/app.py"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt-get install -y python3-pip",
      "sudo apt install python3-flask -y",
      "sudo bash -c 'nohup python3 /home/ubuntu/app.py > /home/ubuntu/app.log 2>&1 &'"
    ]
  }
}
