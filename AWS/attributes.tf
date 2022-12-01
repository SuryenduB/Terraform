resource "aws_eip" "lb" {
  vpc = true
}



resource "aws_s3_bucket" "mys3" {
  bucket = "surylabs-attribute-demo-001"
}

