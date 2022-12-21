variable "subscription_id" {
    default = "3bfeb287-1a11-406b-8e99-0db004b08e8c"
  
}

variable "tenant_id" {
    default = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  
}

# azure region
variable "location" {
  type        = string
  description = "Azure region for the resource group"
  default     = "north europe"
}

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