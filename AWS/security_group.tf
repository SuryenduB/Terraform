resource "aws_security_group" "demo_sg" {
  name        = "dynamic-sg"
  description = "Allow TLS inbound traffic"


  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }


  }

  dynamic "egress" {
    for_each = var.sg_ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }


  }



  tags = {
    Name = "allow_tls"
  }
}


resource "aws_security_group" "allow_tls2" {
  name        = "allow_tls2"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb1.private_ip}/32"]

  }
}