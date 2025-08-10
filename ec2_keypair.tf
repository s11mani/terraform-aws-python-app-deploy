resource "aws_key_pair" "name" {
  public_key = file("./keys/id_rsa.pub")
  key_name   = "${var.project}-keypair"
  tags = {
    Name = "${var.project}-keypair"
  }
}
