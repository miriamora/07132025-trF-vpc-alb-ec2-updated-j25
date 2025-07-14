//create the target group
resource "aws_lb_target_group" "alb_target_group" {
  name     = "webserver-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.alb_vpc.id

  health_check {
    enabled             = true
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 10
    timeout             = 6
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "webserver-target-group"
  }
  depends_on = [aws_vpc.alb_vpc]
}

//attach instances to target group
resource "aws_lb_target_group_attachment" "target_grp_atta_1" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target_grp_atta_2" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target_grp_atta_3" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = aws_instance.webserver3.id
  port             = 80
}

//create application load balancer
resource "aws_lb" "alb" {
  name                             = "webserver-alb"
  internal                         = false
  load_balancer_type               = "application"
  enable_deletion_protection       = false
  security_groups                  = [aws_security_group.alb_sg.id]
  subnets                          = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "webserver-alb"
  }
}

//create alb listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
