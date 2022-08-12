# provider "azurerm" {
#   subscription_id =     var.subscription_id
#   client_id       =     var.client_id
#   client_secret   =     var.client_secret
#   tenant_id       =     var.tenant_id
  
#   features {}
# }

# resource "azurerm_resource_group" "example" {
#   name     = "FrontDoorExampleResourceGroup"
#   location = "West Europe"
# }

# resource "azurerm_frontdoor" "example" {
#   name                = "Sury-FrontDoor"
#   resource_group_name = azurerm_resource_group.example.name

#   dynamic "routing_rule" {
#     for_each = var.routing_rule
#     content {
#       name               = routing_rule.value["name"]
#       accepted_protocols = routing_rule.value["accepted_protocols"]
#       patterns_to_match  = routing_rule.value["patterns_to_match"]
#       frontend_endpoints = routing_rule.value["frontend_endpoints"]
#       dynamic "forwarding_configuration" {
#         for_each = routing_rule.value["forwarding_configuration"]
#         content {
#           forwarding_protocol = forwarding_configuration.value["forwarding_protocol"]
#           backend_pool_name   = forwarding_configuration.value["backend_pool_name"]
#         }

#       }
#     }


#   }

#   backend_pool_load_balancing {
#     name = "exampleLoadBalancingSettings1"
#   }

#   backend_pool_health_probe {
#     name = "exampleHealthProbeSetting1"
#   }

#   dynamic "backend_pool" {
#     for_each = var.backend_pool
#     content {
#       name                = backend_pool.value["name"]
#       load_balancing_name = backend_pool.value["load_balancing_name"]
#       health_probe_name   = backend_pool.value["health_probe_name"]

#       dynamic "backend" {
#         for_each = backend_pool.value["backend"]
#         content {
#           host_header = backend.value["host_header"]
#           address     = backend.value["address"]
#           http_port   = backend.value["http_port"]
#           https_port  = backend.value["https_port"]

#         }

#       }


#     }

#   }

#   frontend_endpoint {
#     name      = "exampleFrontendEndpoint1"
#     host_name = "Sury-FrontDoor.azurefd.net"
#   }
# }

module "virtualnachine" {
  source = "./virtualmachine"
  resourcename  = "AzureRMResource"
  diagnostic = "bootmachinediag"
  env = "dev"
location      = "North Europe"
tags          = { enviornment = "demo", owner = "shan", purpose = "TFdemo" }
storagename   = "azurermtfdemoshan"
containername = "tfdemocontainer"
dnsname       = ["shan.com", "shan1.com", "shan2.com", "shan3.com"]
networkrule = [
  {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"  
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "test1234"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "*"   
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "test1235"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
]
tag2 = {resource="virtualmachine",costcentre = "demoyfcourse"}
enviornment = "sandbox"
account_type = "Standard_GRS"
loc = ["east","us"]
address_space = ["10.0.0.0/16","10.0.0.1/32","10.0.0.1/24","10.0.2.0/23"] 


}