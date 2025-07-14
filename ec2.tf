resource "aws_instance" "webserver1" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  subnet_id                   = aws_subnet.private_subnet_1a.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  user_data                   = file("setup.sh")

  tags = {
    Name = "webserver1"
  }
}

resource "aws_instance" "webserver2" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1b"
  subnet_id                   = aws_subnet.private_subnet_1b.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  user_data                   = file("setup.sh")

  tags = {
    Name = "webserver2"
  }
}

resource "aws_instance" "webserver3" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1b"
  subnet_id                   = aws_subnet.private_subnet_1b.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  user_data                   = file("setup.sh")

  tags = {
    Name = "webserver3"
  }
}