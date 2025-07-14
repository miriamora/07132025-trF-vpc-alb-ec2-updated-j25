//create alb security group to allow http and htps traffic
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "allow HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.alb_vpc.id
  ingress {
    description = "allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//create EC2 security group to allow only traffic from alb
resource "aws_security_group" "instance_sg" {
  name        = "alb_instance_sg"
  vpc_id      = aws_vpc.alb_vpc.id
  description = "allow traffic from alb"
  depends_on  = [aws_security_group.alb_sg]
  ingress {
    description     = "allow http traffic from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
  }
}