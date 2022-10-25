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
  
  management_group_id  = data.azurerm_management_group.TenantRootGroup.id
  parameters           = <<PARAMS
    {
      "Tag Name": {
        "value": "Owner"
      }
    }
    
PARAMS


}




# terraform plan -out assignment.tfplan

