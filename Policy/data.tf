data "azurerm_management_group" "TenantRootGroup" {
  display_name = "Root"
}



data "azurerm_policy_definition" "StorageVNET" {
  display_name = "Storage accounts should restrict network access using virtual network rules"
}
