variable "vpn_ip" {
  default = "116.50.30.50/32"
}
variable "instance_type" {
    default = "t2.micro"
  
}
#terraform plan -var-file="custom.tfvars"