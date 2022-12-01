provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA3WFERZ2IMP4AGGHJ"
  secret_key = var.secret_key

}

#TF_VAR_secret_key is the Secret key defined in global variable. $env:TF_VAR_secret_key


provider "aws" {
  alias      = "southeast"
  region     = "ap-southeast-1"
  access_key = "AKIA3WFERZ2IMP4AGGHJ"
  secret_key = var.secret_key

}
