provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA3WFERZ2IMXK6LBT6"
  secret_key = "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"
}
/*
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
*/

resource "aws_instance" "web" {
  ami           = "ami-0c2ab3b8efb09f272"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}