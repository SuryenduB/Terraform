terraform {
  backend "azurerm" {
    resource_group_name   = "MultiForest-Home-In-World_2"
    storage_account_name  = "az500sury"
    container_name        = "az500sury"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id =     var.subscription_id
  client_id       =     var.client_id
  client_secret   =     var.client_secret
  tenant_id       =     var.tenant_id
  alias  = "backend"
  
  features {}
}

variable "subscription_id" {
  default = ""
}
variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}
variable "tenant_id" {
  default = ""
}