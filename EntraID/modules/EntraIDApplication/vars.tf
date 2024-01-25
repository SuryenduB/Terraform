variable "display_name" {
  type = string
}

variable "identifier_uris" {
  type = list(string)
}

variable "sign_in_audience" {
  type = string
  default = "AzureADMyOrg"
}

variable "path_to_logo_image" {
  type = string
  default = null
}

variable "app_roles" {
  type = list(object({
    
    description          = string
    display_name         = string
    value                = string
  }))
  default = [ 
    
  ]
  
}

variable id_token {
  type = list(object({
    name = string,
    essential = bool,
    source = string,
    additional_properties = list(string)
  }))
  default = [ 
    
  ]
} 


variable access_token {
  type = list(object({
    name = string,
    essential = bool,
    source = string,
    additional_properties = list(string)
  }))
  default = [ 
    
  ]
} 

variable saml2_token {
  type = list(object({
    name = string,
    essential = bool,
    source = string,
    additional_properties = list(string)
  }))
  default = [ 
    
  ]
  
}