output storageaccount_resource_group {
  value = var.storageaccount_resource_group_name
  depends_on = [azurerm_resource_group.storageaccount_resource_group]
}