provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA3WFERZ2IMP4AGGHJ"
  secret_key = var.secret_key

}

#TF_VAR_secret_key is the Secret key defined in global variable. $env:TF_VAR_secret_key


variable "secret_key" {
  
}

resource "aws_instance" "web" {
  ami           = "ami-0c2ab3b8efb09f272"
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}

