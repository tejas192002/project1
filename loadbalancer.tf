resource "aws_lb" "external-alb" {
  name               = "External LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.public_subnet.id]
}

resource "aws_lb_target_group" "target-elb" {
  name     = "ALB TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}
