provider "azurerm" {


  features {}
}
/*
data "azurerm_resources" "listofresource" {
  resource_group_name = "Az500"
}

output "resource" {
  value = data.azurerm_resources.listofresource.resources.*.name

}

data "azurerm_subscriptions" "azurermsub" {
}

output "available_sub" {
  value = data.azurerm_subscriptions.azurermsub.subscriptions
}
*/
data "azurerm_subscription" "primary" {
}

data "azurerm_role_definition" "example" {
  name        = "Owner"
  scope       = data.azurerm_subscription.primary.id
}

output "role_definition_id" {
  value = data.azurerm_role_definition.example.role_definition_id
}