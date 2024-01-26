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
  default = null
}

variable access_token {
  type = list(object({
    name = string,
    essential = bool,
    source = string,
    additional_properties = list(string)
  }))
  default = null
} 

variable saml2_token {
  type = list(object({
    name = string,
    essential = bool,
    source = string,
    additional_properties = list(string)
  }))
  default = null
  
}
variable "app_role_assignment_required" {
  type = bool
  default = true


}

variable "description" {
  type = string
  default = null
  
}

variable "preferred_single_sign_on_mode" {
  type = string
  default = "notSupported"
  
}

variable "relay_state" {
  type = string
  default = null
  
}

variable "generate_certificate" {
  type = bool
  default = false
  
}

variable "claims_mapping_policy" {
  type = object({
    claims_schema = list(object({
      id = string,
      jwt_claim_type = string,
      Saml_Claim_Type = string,
      source = string
    }))
    include_basic_claim_set = string
    version = number
  })
  default = null

  
}