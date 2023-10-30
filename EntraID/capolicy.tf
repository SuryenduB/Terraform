resource "azuread_conditional_access_policy" "CA01-BlockHighRiskUsers" {
  display_name = "Block high risk users"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = ["high"]
    user_risk_levels    = ["high"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }


    users {
      included_users = ["All"]
      excluded_users = ["GuestsOrExternalUsers"]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }


}