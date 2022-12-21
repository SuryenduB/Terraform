# Define Terraform provider

# Configure the Azure provider
provider "azurerm" { 
  features {}
  environment     = "public"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module "storage" {
  source = "./Modules"
  object_id = "4ca10683-4617-440c-88e9-ce217747d7e0"
  
}
