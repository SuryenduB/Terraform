terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.47.0"
    }
  }

}
# Configure the Microsoft Azure Provider
provider "azuread" {
  #use_oidc = true
  tenant_id = "b5683b08-cb53-45a8-b4ff-1531a0ed2f38"

}