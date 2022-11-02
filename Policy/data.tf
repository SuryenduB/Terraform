data "azurerm_management_group" "TenantRootGroup" {
  display_name = "Root"
}

data "azurerm_management_group" "NP-AVIVA" {
  display_name = "NP-AVIVA"
}

data "azurerm_management_group" "PR-AVIVA" {
  display_name = "PR-AVIVA"
}

locals {
  policies = csvdecode(file("policy.csv"))
  np_aviva_policies = csvdecode(file("np-aviva-policy.csv"))
  pr_aviva_policies = csvdecode(file("pr-aviva-policy.csv"))
}
data "azurerm_policy_definition" "BuiltInPolicies" {
  for_each = { for policy in local.policies  : policy.policy_name => policy }
  display_name = each.value.policy_name
  
}

data "azurerm_policy_definition" "NPAvivaBuiltInPolicies" {
  for_each = { for policy in local.np_aviva_policies  : policy.policy_name => policy }
  display_name = each.value.policy_name
  
}

data "azurerm_policy_definition" "PRAvivaBuiltInPolicies" {
  for_each = { for policy in local.pr_aviva_policies  : policy.policy_name => policy }
  display_name = each.value.policy_name
  
}





# data "azurerm_policy_definition" "StorageVNET" {
#   display_name = "Configure diagnostic settings for storage accounts to Log Analytics workspace"
# }
