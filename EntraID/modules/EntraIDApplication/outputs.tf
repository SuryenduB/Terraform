output "application_group" {
    value = azuread_group.example_administer_group
}

output "access_package" {
    value = azuread_access_package.application_roles 
}

output "azuread_access_package_resource_package_association" {
  value = azuread_access_package_resource_package_association.azuread_access_package_resource_catalog_association
}