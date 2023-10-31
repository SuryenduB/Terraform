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

resource "azuread_conditional_access_policy" "CA203-Internals-IdentityProtection-AllApps-AnyPlatform-MFAforHighSignInRisk" {
  display_name = "CA203-Internals-IdentityProtection-AllApps-AnyPlatform-MFAforHighSignInRisk"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]
     
    }
    platforms {
      included_platforms = ["all"]
    }
    client_app_types = [ "all" ]
    sign_in_risk_levels = [ "high" ]


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id,azuread_group.internals-BaseProtection-exclusion.id]
    }


    
    
    
  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }

  session_controls {
    sign_in_frequency_interval = "everyTime"
  }


}

resource "azuread_conditional_access_policy" "CA204-Internals-IdentityProtection-AllApps-AnyPlatform-BlockLegacyAuth" {
  display_name = "CA204-Internals-IdentityProtection-AllApps-AnyPlatform-BlockLegacyAuth"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]
     
    }
    platforms {
      included_platforms = ["all"]
    }
    client_app_types = [ "exchangeActiveSync","other" ]
    sign_in_risk_levels = [ "high" ]


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id,azuread_group.internals-BaseProtection-exclusion.id]
    }  
  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["block"]
  }

}