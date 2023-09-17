terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.23.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azuread" {
  use_oidc = true
  
}