provider "aws" {
  alias      = "southeast"
  region     = "ap-southeast-1"
  access_key = "AKIA3WFERZ2IMP4AGGHJ"
  secret_key = var.secret_key

}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "instance-2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}
