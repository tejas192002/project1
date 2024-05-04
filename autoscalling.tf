resource "aws_autoscaling_group" "asg" {
  name                      = "example-asg" 
  launch_configuration      = aws_launch_configuration.asg_lc.id
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  vpc_zone_identifier       = [aws_subnet.private_subnet.id] 
  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_launch_configuration" "asg_lc" {
  name          = "example-lc"
  image_id      = "ami-0b419c3a4b01d1859" 
  instance_type = "t2.micro"
  key_name      = "universal_key"
  security_groups = [aws_security_group.sg.id] 
  user_data     = <<-EOF
                  #!/bin/bash
                  echo "Hello, World!" > /tmp/hello.txt
                  EOF
}   