terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.28.1"

    }

  }
}


provider "azurerm" {
  # Configuration options
  features {}

}


provider "azuread" {
  # Configuration options



}



data "azuread_group" "groups" {
    for_each = toset(var.groups)
  display_name = each.key


}




data "azurerm_subscription" "primary" {
}





resource "azurerm_role_assignment" "example" {

for_each = data.azuread_group.groups
scope = data.azurerm_subscription.primary.id

role_definition_name = "Support Request Contributor"

principal_id  = data.azuread_group.groups[each.key].id

}

  



