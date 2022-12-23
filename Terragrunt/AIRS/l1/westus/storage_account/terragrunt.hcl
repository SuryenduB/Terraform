terraform {
  source = "tfr:///Azure/vnet/azurerm//?version=2.6.0"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../../global/resource_groups"]
}

dependency "resource_groups" {
  config_path = "../../global/resource_groups"

  mock_outputs = {
    storageaccount_resource_group_name = "rg-terragrunt-mock-001"
  }

  mock_outputs_merge_with_state = true
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_vars.locals.environment

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  location = local.region_vars.locals.location
}

inputs = {
  vnet_name           = "vnet-spoke-${local.environment}-${local.location}-001"
  resource_group_name = dependency.resource_groups.outputs.storageaccount_resource_group_name
  location            = local.location

  tags = {
    environment = local.environment
  }
}