# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "azurerm_network_security_rule" "AllowLDAPsInboundWhitelist" {
  access                                     = "Allow"
  description                                = "Allow LDAP  (Home Lab) 46.114.180.35"
  destination_address_prefix                 = null
  destination_address_prefixes               = ["10.0.0.4", "10.0.0.5"]
  destination_application_security_group_ids = []
  destination_port_ranges                    = ["389", "7389"]
  direction                                  = "Inbound"
  name                                       = "NSGRuleLDAP"
  network_security_group_name                = "IAM-STG-NSG"
  priority                                   = 2010
  protocol                                   = "*"
  resource_group_name                        = "IAM-STG-RSG"
  source_address_prefix                      = null
  source_address_prefixes                    = ["13.79.85.90", "20.238.65.61", "212.91.244.2", "34.254.60.147", "46.114.180.35", "52.48.92.0", "77.247.82.165", "85.239.123.201","52.215.45.1"]
  source_application_security_group_ids      = []
  source_port_range                          = "*"
  
}
