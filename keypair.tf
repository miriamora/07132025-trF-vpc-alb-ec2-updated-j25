//keypair not needed since the ec2 servers are in the private subnets -accesible only from the alb"
/*
resource "tls_private_key" "alb_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "alb_key_keypair" {
  public_key = tls_private_key.alb_key.public_key_openssh
  key_name   = "alb_key"
}

resource "local_file" "alb_key_pem" {
  filename        = "${aws_key_pair.alb_key_keypair.key_name}.pem"
  file_permission = 0400
  content         = tls_private_key.alb_key.private_key_pem
}
*/