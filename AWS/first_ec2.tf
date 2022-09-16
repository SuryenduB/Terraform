provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA3WFERZ2IFOTWTMMD"
  secret_key = var.secret_key

}


variable "secret_key" {
  
}

resource "aws_instance" "web" {
  ami           = "ami-0c2ab3b8efb09f272"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

