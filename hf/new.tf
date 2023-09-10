# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "azurerm_network_security_rule" "AllowLDAPsInboundWhitelist" {
  access                                     = "Allow"
  description                                = null
  destination_address_prefix                 = null
  destination_address_prefixes               = ["10.11.11.5", "10.11.11.6"]
  destination_application_security_group_ids = []
  destination_port_range                     = "636"
  direction                                  = "Inbound"
  name                                       = "AllowLDAPsInboundWhitelist"
  network_security_group_name                = "IAM-PRD-NSG"
  priority                                   = 1002
  protocol                                   = "*"
  resource_group_name                        = "IAM-PRD-RSG"
  source_address_prefix                      = null
  source_address_prefixes                    = ["13.236.164.39", "168.63.129.16", "212.91.244.2", "34.241.251.84", "34.248.252.181", "52.48.110.57", "52.48.92.0", "54.206.155.24", "85.239.123.201"]
  source_application_security_group_ids      = []
  source_port_range                          = "*"
}
