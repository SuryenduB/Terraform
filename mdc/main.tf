terraform {
  required_version = ">=0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_security_center_subscription_pricing" "mdc_servers" {
  tier          = "Standard"
  resource_type = "StorageAccounts"
}

