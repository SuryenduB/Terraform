data "azurerm_client_config" "current" {}
resource "azurerm_resource_group" "example" {
  name     = "rg-demo-internal-shared-cox-poc-002"
  location = "East US"
}



resource "azurerm_virtual_network" "network-vnet" {
  name                = "network-vnet-eu-cox-psc-poc01"
  address_space       = [var.network-vnet-cidr]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}
# Create a subnet for VM
resource "azurerm_subnet" "endpoint-subnet" {
  name                 = "endpoint-subnet"
  address_prefixes     = [var.endpoint-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  resource_group_name  = azurerm_resource_group.example.name
  private_endpoint_network_policies_enabled = true
}

resource "azurerm_storage_account" "asa" {
  name                     = "saeucoxpoc01"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version           = var.min_tls_version
  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "staging"
  }
}

# Create Private Endpint
resource "azurerm_private_endpoint" "endpoint" {
  name                = "eu-cox-pe-poc01"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = azurerm_subnet.endpoint-subnet.id
  private_service_connection {
    name                           = "eu-cox-psc-poc01"
    private_connection_resource_id = azurerm_storage_account.asa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
    
  }
}

resource "azurerm_key_vault" "example" {
  name                = "kv-eu-cox-poc02"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_storage_account.asa.identity.0.principal_id

  key_permissions    = ["Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get"]
  depends_on = [
    azurerm_storage_account.asa
  ]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "example" {
  name         = "tfex-key-eu-cox-psc-poc01"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.storage,
  ]
}

resource "azurerm_storage_account_customer_managed_key" "example" {
  storage_account_id = azurerm_storage_account.asa.id
  key_vault_id       = azurerm_key_vault.example.id
  key_name           = azurerm_key_vault_key.example.name
}