resource "azuread_conditional_access_policy" "CA200-Internals-BaseProtection-AllApps-AnyPlatform-CompliantorAADHJ" {
  display_name = "Block high risk users 1"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]
      excluded_applications = [data.azuread_service_principal.intune]
    }
    platforms {
      included_platforms = ["All"]
      
    }


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id,azuread_group.internals-BaseProtection-exclusion.id]
    }
    client_app_types    = ["all"]
    
    
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["compliantDevice","domainJoinedDevice"]
  }


}