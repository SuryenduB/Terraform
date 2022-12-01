




resource "aws_instance" "web" {
  ami           = "ami-0c2ab3b8efb09f272"
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}

