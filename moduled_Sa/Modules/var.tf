variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
  default = "10.10.0.0/16"
}

variable "endpoint-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
  default = "10.10.0.0/24"
}

variable "tenant_id" {
    type        = string
    description = "Azure AD Tenant ID"
    default = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  
}
variable "min_tls_version" {
    default = "TLS1_2"
  
}

variable "object_id" {
    type = string
  
}