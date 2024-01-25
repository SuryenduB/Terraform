locals {
  app_roles = { for role in var.app_roles : role.display_name => role }
  optional_claims = {
    id_token = var.id_token
    access_token = var.access_token
    saml2_token = var.saml2_token
  }
  logo_image = filebase64(var.path_to_logo_image)
  #generate map from var.id_token
  id_token = { for token in var.id_token : token.name => token }


}

# Manage the Application itself

data "azuread_client_config" "current" {}

resource "azuread_application" "example" {
  display_name     = var.display_name
  identifier_uris  = var.identifier_uris
  logo_image       = local.logo_image
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = var.sign_in_audience

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    
    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
      admin_consent_display_name = "Access example"
      enabled                    = true
      id                         = "96183846-204b-4b43-82e1-5d2222eb4b9b"
      type                       = "User"
      user_consent_description   = "Allow the application to access example on your behalf."
      user_consent_display_name  = "Access example"
      value                      = "user_impersonation"
    }

    
  }

  # app_role {
  #   allowed_member_types = ["User", "Application"]
  #   description          = "Admins can manage roles and perform all task actions"
  #   display_name         = "Admin"
  #   enabled              = true
  #   id                   = "1b19509b-32b1-4e9f-b71d-4992aa991967"
  #   value                = "admin"
  # }

  # app_role {
  #   allowed_member_types = ["User"]
  #   description          = "ReadOnly roles have limited query access"
  #   display_name         = "ReadOnly"
  #   enabled              = true
  #   id                   = "497406e4-012a-4267-bf18-45a1cb148a01"
  #   value                = "User"
  # }



  lifecycle {
    ignore_changes = [
      app_role,
    ]
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  

  web {
    homepage_url  = "https://app.example.net"
    logout_url    = "https://app.example.net/logout"
    redirect_uris = ["https://app.example.net/account"]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }
}


# Application Roles to be added to the Application Registration

resource "random_uuid" "example_administrator" {}


resource "random_uuid" "example" {
  for_each = local.app_roles

}


# Application Roles to be added to the Application Registration


resource "azuread_application_app_role" "example_administer" {
  application_id         = azuread_application.example.application_id
  for_each               = local.app_roles
  role_id                = random_uuid.example_administrator.id
  allowed_member_types   = ["User"]
  description            = each.value.description
  display_name           = each.key
  value                  = replace(each.value.value, "/[^a-zA-Z0-9]/", "")
}
  


# Optional Claims to be added to the Application Registration

resource "azuread_application_optional_claims" "example" {
  application_id = azuread_application.example.application_id

  count = length(var.id_token) > 0 || length(var.access_token) > 0 || length(var.saml2_token) > 0 ? 1 : 0
  # If Id token is not empty, create a block for it
  dynamic "id_token" {
    for_each = var.id_token
    iterator = token
    content {
      name = token.value.name
      essential = token.value.essential
      source = token.value.source
      additional_properties = token.value.additional_properties
    }
    
  }

  #create a dynamic block for each token in local.id_token
  dynamic "access_token" {
    for_each = var.access_token
    iterator = token
    content {
      name = token.value.name
      essential = token.value.essential
      source = token.value.source
      additional_properties = token.value.additional_properties
    }
    
  }
  dynamic "saml2_token" {
    for_each = var.saml2_token
    iterator = token
    content {
      name = token.value.name
      essential = token.value.essential
      source = token.value.source
      additional_properties = token.value.additional_properties
    }
    
  }
  
}