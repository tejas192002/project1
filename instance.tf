resource "aws_instance" "jump" {
  ami                         = "ami-0b419c3a4b01d1859"
  instance_type               = "t2.micro"
  key_name                    = "universal_key"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "jump-server"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-0b419c3a4b01d1859"
  instance_type               = "t2.micro"
  key_name                    = "universal_key"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.private_subnet.id
  private_ip                  = "10.0.1.11"
  associate_public_ip_address = false
  tags = {
    Name = "web-server"
  }
}

resource "aws_instance" "web2" {
  ami                         = "ami-0b419c3a4b01d1859"
  instance_type               = "t2.micro"
  key_name                    = "universal_key"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.private_subnet1.id
  private_ip                  = "10.0.1.12" 
  associate_public_ip_address = false
  tags = {
    Name = "web-server2"
  }
}
