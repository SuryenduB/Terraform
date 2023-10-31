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



