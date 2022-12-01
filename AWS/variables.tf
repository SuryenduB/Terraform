variable "vpn_ip" {
  default = "116.50.30.50/32"
}
variable "instance_type" {
  default = "t2.micro"

}

variable "usernumber" {
  type    = number
  default = 12345

}

variable "elb_name" {
  type = string
}

variable "az" {
  type = list(any)
}

variable "timeout" {
  type = number
}


variable "elb_names" {
  type    = list(any)
  default = ["dev-loadbalancer", "stage-loadbalanacer", "prod-loadbalancer"]
}

variable "istest" {}

variable "secret_key" {

}

variable "region" {
  default = "ap-south-1"
}

variable "tags" {
  type    = list(any)
  default = ["firstec2", "secondec2"]
}

variable "ami" {
  type = map(any)
  default = {
    "us-east-1"  = "ami-0323c3dd2da7fb37d"
    "us-west-2"  = "ami-0d6621c01e8c2de2c"
    "ap-south-1" = "ami-0470e33cd681b2476"
  }
}
#terraform plan -var-file="custom.tfvars"