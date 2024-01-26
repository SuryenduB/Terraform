locals {
  app_roles = { for role in var.app_roles : role.display_name => role }
  optional_claims = {
    id_token     = var.id_token
    access_token = var.access_token
    saml2_token  = var.saml2_token
  }
  logo_image = filebase64(var.path_to_logo_image)
  #generate map from var.id_token
  claims_mapping_policy = {
    definition = [
      jsonencode(
       var.claims_mapping_policy

      )
    ],
    display_name = "EntraID Claims Mapping Policy - ${var.display_name}"
  }
  create_claim_mapping_policy = var.claims_mapping_policy != null ? true : false




}

# Manage the Application itself

data "azuread_client_config" "current" {}

resource "azuread_application" "example" {
  display_name     = var.display_name
  identifier_uris  = var.identifier_uris
  logo_image       = local.logo_image
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = var.sign_in_audience
  description      = var.description

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2





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
      required_resource_access,
      optional_claims,
    ]
  }

  # required_resource_access {
  #   resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

  #   resource_access {
  #     id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
  #     type = "Scope"
  #   }
  # }



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
  application_id       = azuread_application.example.id
  for_each             = local.app_roles
  role_id              = random_uuid.example_administrator.id
  allowed_member_types = ["User"]
  description          = each.value.description
  display_name         = each.key
  value                = replace(each.value.value, "/[^a-zA-Z0-9]/", "")
}



# Optional Claims to be added to the Application Registration

resource "azuread_application_optional_claims" "example" {
  application_id = azuread_application.example.id

  count = var.id_token != null || var.access_token != null || var.saml2_token != null ? 1 : 0
  # If Id token is not empty, create a block for it
  dynamic "id_token" {
    for_each = var.id_token != null ? { this = var.id_token } : {}
    iterator = token
    content {
      name                  = token.value[count.index].name
      essential             = token.value[count.index].essential
      source                = token.value[count.index].source
      additional_properties = token.value[count.index].additional_properties
    }

  }

  #create a dynamic block for each token in local.id_token
  dynamic "access_token" {
    for_each = var.access_token != null ? { this = var.access_token } : {}

    content {
      name                  = token.value[count.index].name
      essential             = token.value[count.index].essential
      source                = token.value[count.index].source
      additional_properties = token.value[count.index].additional_properties
    }

  }
  dynamic "saml2_token" {
    for_each = var.saml2_token != null ? { this = var.saml2_token } : {}
    iterator = token
    content {
      name                  = token.value[count.index].name
      essential             = token.value[count.index].essential
      source                = token.value[count.index].source
      additional_properties = token.value[count.index].additional_properties
    }

  }

}

# Add API Access to the Application Registration
resource "azuread_application_api_access" "example_msgraph" {
  application_id = azuread_application.example.id
  api_client_id  = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]

  role_ids = [
    data.azuread_service_principal.msgraph.app_role_ids["Group.Read.All"],
    data.azuread_service_principal.msgraph.app_role_ids["User.Read.All"],
  ]

  scope_ids = [
    data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.ReadWrite"],
    data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["profile"],
  ]
}

# Create a Service Principal for the Application Registration

resource "azuread_service_principal" "example" {
  depends_on                   = [azuread_application.example]
  client_id                    = azuread_application.example.client_id
  app_role_assignment_required = var.app_role_assignment_required
  owners                       = [data.azuread_client_config.current.object_id]
  description                  = var.description
  feature_tags {
    custom_single_sign_on = true
  }
  preferred_single_sign_on_mode = var.preferred_single_sign_on_mode
  saml_single_sign_on {
    relay_state = var.relay_state
  }
  
}

resource "azuread_service_principal_certificate" "example" {
  count = var.generate_certificate ? 1 : 0
  service_principal_id = azuread_service_principal.example.id
  type                 = "AsymmetricX509Cert"
  value                = file("cert.pem")
  end_date_relative    = "8760h" # 1 year
}

resource "azuread_claims_mapping_policy" "my_policy" {
  count       = local.create_claim_mapping_policy ? 1 : 0
  display_name = local.claims_mapping_policy.display_name
  definition   = local.claims_mapping_policy.definition
}

resource "azuread_service_principal_claims_mapping_policy_assignment" "app" {
  count       = local.create_claim_mapping_policy ? 1 : 0
  claims_mapping_policy_id = azuread_claims_mapping_policy.my_policy[count.index].id
  service_principal_id     = azuread_service_principal.example.id
}