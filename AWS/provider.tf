provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA3WFERZ2IA5GBFPML"
  secret_key = var.secret_key

}



provider "aws" {
  alias      = "southeast"
  region     = "ap-southeast-1"
  access_key = "AKIA3WFERZ2IA5GBFPML"
  secret_key = var.secret_key

}
