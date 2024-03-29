terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.47.0"
    }
  }

  /*backend "azurerm" {
    storage_account_name = "iamstgsa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.

  }*/


}
# Configure the Microsoft Azure Provider
provider "azuread" {
  #use_oidc = true
  tenant_id = "b5683b08-cb53-45a8-b4ff-1531a0ed2f38"

}