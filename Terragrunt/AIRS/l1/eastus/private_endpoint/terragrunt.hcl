terraform {
  source = "tfr:///andrewCluey/private-endpoint/azurerm//?version=2.0.4"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../../global/resource_groups","../storage_account"]
}

dependency "resource_groups" {
  config_path = "../../global/resource_groups"

  mock_outputs = {
    pe_resource_group_name = "rg-terragrunt-mock-001"
  }
  mock_outputs_merge_with_state = true
}

dependency "storage_account" {
  config_path = "../storage_account"

  mock_outputs = {
    storage_account_name = "stterragruntexample005"
    id = "/subscriptions/7b5c7d11-8bc3-4105-9c6f-41222b38b95f/resourceGroups/rg-sqlvm-cox-poc-01/providers/Microsoft.Storage/storageAccounts/stterragruntexample005"
  }
  mock_outputs_merge_with_state = true
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_vars.locals.environment

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  location = local.region_vars.locals.location

  subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  subscription_id = local.subscription_vars.locals.subscription_id
}

inputs = {
  pe_resource_group_name = dependency.resource_groups.outputs.pe_resource_group_name
  private_endpoint_name  = "sa${local.environment}${local.location}001-pe"
  subresource_names      = ["blob"]
  endpoint_resource_id   = dependency.storage_account.outputs.id
  pe_network = {
    resource_group_name = "rg-sqlvm-cox-poc-01"
    vnet_name           = "vnet-eus-sqlvm-01" 
    subnet_name         = "snet-eus-sqlvm-01"
  }
  dns = {
    zone_ids   = ["/subscriptions/7b5c7d11-8bc3-4105-9c6f-41222b38b95f/resourcegroups/rg-sqlvm-cox-poc-01/providers/Microsoft.Network/privateDnsZones/private.blob.zone"]
    zone_name  = "private.blob.zone"
  }  
  

  tags = {
    environment = local.environment
  }
}