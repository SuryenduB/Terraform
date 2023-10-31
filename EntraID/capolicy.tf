resource "azuread_conditional_access_policy" "CA200-Internals-BaseProtection-AllApps-AnyPlatform-CompliantorAADHJ" {
  display_name = "CA200-Internals-BaseProtection-AllApps-AnyPlatform-CompliantorAADHJ"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]
      excluded_applications = [data.azuread_service_principal.intune.client_id]
    }
    platforms {
      included_platforms = ["all"]
      
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

resource "azuread_conditional_access_policy" "CA202-Internals-IdentityProtection-AllApps-AnyPlatform-MFAandPWDforHighUserRisk" {
  display_name = "CA202-Internals-IdentityProtection-AllApps-AnyPlatform-MFAandPWDforHighUserRisk"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]
      excluded_applications = [data.azuread_service_principal.intune.client_id]
    }
   
    client_app_types    = ["all"]
    user_risk_levels    = ["high"]


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id,azuread_group.internals-BaseProtection-exclusion.id]
    }
    
    
    
  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["passwordChange","mfa"]
  }


}