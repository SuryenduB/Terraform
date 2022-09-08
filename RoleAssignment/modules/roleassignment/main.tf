resource "azurerm_role_assignment" "example" {

count = length(var.role_definition_name)
scope = var.scope

role_definition_name = var.role_definition_name[count.index]

principal_id  = var.principal_id

}