data "azuread_client_config" "current" {}



resource "azuread_group" "internals" {
  display_name     = "CA-Persona-Internals "
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.employeeid -match \"\\d{5}$\""
  }
}


resource "azuread_group" "breakglass" {
  display_name     = "CA-Breakglass"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "internals-BaseProtection-exclusion" {
  display_name     = "CA-Persona-Internals-BaseProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "internals-AppProtection-exclusion" {
  display_name     = "CA-Persona-Internals-AppProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "internals-IdentityProtection-exclusion" {
  display_name     = "CA-Persona-Internals-IdentityProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "internals-DataProtection-exclusion" {
  display_name     = "CA-Persona-Internals-DataProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "Internals-AttackSurfaceReduction-Exclusions" {
  display_name     = "CA-Persona-Internals-AttackSurfaceReduction-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}


# External Persona

resource "azuread_group" "externals-BaseProtection-exclusion" {
  display_name     = "CA-Persona-Externals-BaseProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "externals-IdentityProtection-exclusion" {
  display_name     = "CA-Persona-Externals-IdentityProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

}

resource "azuread_group" "externals-AppProtection-exclusion" {
  display_name     = "CA-Persona-Externals-AppProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "externals-DataProtection-exclusion" {
  display_name     = "CA-Persona-Externals-DataProtection-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}


resource "azuread_group" "Externals-AttackSurfaceReduction-Exclusions" {
  display_name     = "CA-Persona-Externals-AttackSurfaceReduction-Exclusions"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true


}

resource "azuread_group" "externals" {
  display_name     = "CA-Persona-Externals"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.userPrincipalName -contains \"ext\"" # Extenal Users have UPN with ext in it
  }
}



