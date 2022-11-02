provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}




resource "azurerm_subscription_policy_assignment" "auditvms" {
  name                 = "audit-vm-manageddisks"
  subscription_id      = var.cust_scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
  description          = "Shows all virtual machines not using managed disks"
  display_name         = "Audit VMs without managed disks assignment"
}

resource "azurerm_management_group_policy_assignment" "example" {
  name                 = "tag_resource_group"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"

  management_group_id = data.azurerm_management_group.TenantRootGroup.id
  parameters          = <<PARAMS
    {
      "tagName": {
        "value": "Owner"
      }
    }
    
PARAMS


}

# resource "azurerm_management_group_policy_assignment" "SVnet" {
#   display_name                 = "Configure diagnostic settings for storage accounts to Log Analytics workspace"
#   name         = "${substr(data.azurerm_policy_definition.StorageVNET.display_name,-30,23)}"

#   policy_definition_id = data.azurerm_policy_definition.StorageVNET.id

#   management_group_id = data.azurerm_management_group.TenantRootGroup.id
#   parameters          = <<PARAMS
#     {
#       "effect": {
#         "value": "Deny"
#       }
#     }

# PARAMS



# }

resource "azurerm_management_group_policy_assignment" "BuiltInPolicyAssignment" {
  for_each             = data.azurerm_policy_definition.BuiltInPolicies
  name                 = substr(each.value.display_name, -30, 23)
  display_name         = each.value.display_name
  policy_definition_id = each.value.id

  management_group_id = data.azurerm_management_group.TenantRootGroup.id
  parameters          = <<PARAMS
    {
      "effect": {
        "value": "Deny"
      }
    }
    
PARAMS



}


resource "azurerm_management_group_policy_assignment" "NPAvivaBuiltInPolicyAssignment" {
  for_each             = data.azurerm_policy_definition.NPAvivaBuiltInPolicies
  name                 = substr(each.value.display_name, -30, 23)
  display_name         = each.value.display_name
  policy_definition_id = each.value.id

  management_group_id = data.azurerm_management_group.NP-AVIVA.id
  parameters          = <<PARAMS
    {
      "effect": {
        "value": "Deny"
      }
    }
    
PARAMS



}

resource "azurerm_management_group_policy_assignment" "PRAvivaBuiltInPolicyAssignment" {
  for_each             = data.azurerm_policy_definition.PRAvivaBuiltInPolicies
  name                 = substr(each.value.display_name, -30, 23)
  display_name         = each.value.display_name
  policy_definition_id = each.value.id

  management_group_id = data.azurerm_management_group.PR-AVIVA.id
}


# terraform plan -out assignment.tfplan

