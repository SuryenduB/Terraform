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