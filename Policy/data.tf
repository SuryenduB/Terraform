data "azurerm_management_group" "TenantRootGroup" {
  display_name = "Root"
}


locals {
  policies = csvdecode(file("policy.csv"))
}
data "azurerm_policy_definition" "BuiltInPolicies" {
  for_each = { for policy in local.policies  : policy.policy_name => policy }
  display_name = each.value.policy_name
  
}





data "azurerm_policy_definition" "StorageVNET" {
  display_name = "Storage accounts should restrict network access using virtual network rules"
}
