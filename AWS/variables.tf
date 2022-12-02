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
  default = "us-west-2"
}

variable "tags" {
  type    = list(any)
  default = ["firstec2", "secondec2"]
}

variable "ami" {
  type = map(any)
  default = {
    "us-east-1" = "ami-0323c3dd2da7fb37d"
    "us-west-2" = "ami-0d6621c01e8c2de2c"

  }
}

variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201, 8300, 9200, 9500]


}

variable "instance_typews" {
  type = map(any)
  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prod    = "t2.large"
  }



}


#terraform plan -var-file="custom.tfvars"