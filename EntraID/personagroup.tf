data "azuread_client_config" "current" {}

resource "azuread_group" "internals" {
  display_name     = "CA-Persona-Internals "
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.department -eq \"\\d{5}$\""
  }
}

