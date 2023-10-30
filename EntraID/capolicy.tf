resource "azuread_conditional_access_policy" "CA01-BlockHighRiskUsers" {
  display_name = "Block high risk users 1"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]
      excluded_applications = []
    }


    users {
      included_users = ["All"]
      excluded_users = ["GuestsOrExternalUsers"]
    }
    client_app_types    = ["all"]
    
    
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }


}