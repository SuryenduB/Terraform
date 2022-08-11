variable "rgname" {

  description = "Terraform Resource Group"


}
variable "location" {


}

variable "storagename" {


}

variable "subscription_id" {
  default = ""
}
variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}
variable "tenant_id" {
  default = ""
}


variable "tag" {
  type = map(any)

}

variable "routing_rule" {
  default = [
    {
      name               = "exampleRoutingRule1"
      accepted_protocols = ["Https"]
      patterns_to_match  = ["/*"]
      frontend_endpoints = ["exampleFrontendEndpoint1"]
      forwarding_configuration = [{
        forwarding_protocol = "MatchRequest"
        backend_pool_name   = "exampleBackendBing"
      }]
    },
    {
      name               = "exampleRoutingRule2"
      accepted_protocols = ["Http"]
      patterns_to_match  = ["/*"]
      frontend_endpoints = ["exampleFrontendEndpoint1"]
      forwarding_configuration = [{
        forwarding_protocol = "MatchRequest"
        backend_pool_name   = "exampleBackendBing2"
      }]
    }

  ]

}

variable "backend_pool" {
  default = [
    {
      name                = "exampleBackendBing"
      load_balancing_name = "exampleLoadBalancingSettings1"
      health_probe_name   = "exampleHealthProbeSetting1"
      backend = [{
        host_header = "www.bing.com"
        address     = "www.bing.com"
        http_port   = 80
        https_port  = 443
      }]



    },
    {
      name                = "exampleBackendBing1"
      load_balancing_name = "exampleLoadBalancingSettings1"
      health_probe_name   = "exampleHealthProbeSetting1"
      backend = [{
        host_header = "www.bing.com"
        address     = "www.bing.com"
        http_port   = 80
        https_port  = 443
      }]



    },
    {
      name                = "exampleBackendBing2"
      load_balancing_name = "exampleLoadBalancingSettings1"
      health_probe_name   = "exampleHealthProbeSetting1"
      backend = [{
        host_header = "www.bing.com"
        address     = "www.bing.com"
        http_port   = 80
        https_port  = 443
      }]



    }
  ]

}