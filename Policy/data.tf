data "azurerm_management_group" "TenantRootGroup" {
  display_name = "Root"
}

output "display_name" {
  value = data.azurerm_management_group.TenantRootGroup.display_name
}