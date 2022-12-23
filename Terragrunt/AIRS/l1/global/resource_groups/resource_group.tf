resource "azurerm_resource_group" "storageaccount_resource_group" {
  name     = var.storageaccount_resource_group_name
  location = var.location
}

