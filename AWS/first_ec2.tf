




resource "aws_instance" "web" {
  ami           = "ami-0c2ab3b8efb09f272"
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_instance" "myec2" {
  ami           = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
  provider = aws.southeast
}
