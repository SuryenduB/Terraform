variable "vpn_ip" {
  default = "116.50.30.50/32"
}
variable "instance_type" {
    default = "t2.micro"
  
}

variable "usernumber" {
  type = number
  default = 12345
  
}

variable "elb_name" {
  type = string
}

variable "az" {
  type = list
}

variable "timeout" {
  type = number
}


variable "elb_names" {
  type = list
  default = ["dev-loadbalancer", "stage-loadbalanacer","prod-loadbalancer"]
}

variable "istest" {}
#terraform plan -var-file="custom.tfvars"