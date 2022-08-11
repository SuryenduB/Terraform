terraform {
  backend "azurerm" {
    resource_group_name   = "MultiForest-Home-In-World_2"
    storage_account_name  = "az500sury"
    container_name        = "az500sury"
    key                   = "terraform.tfstate"
  }
}