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
      excluded_groups = [azuread_group.breakglass.id, azuread_group.internals-BaseProtection-exclusion.id]
    }
    client_app_types = ["all"]


  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["compliantDevice", "domainJoinedDevice"]
  }


}

resource "azuread_conditional_access_policy" "CA202-Internals-IdentityProtection-AllApps-AnyPlatform-MFAandPWDforHighUserRisk" {
  display_name = "CA202-Internals-IdentityProtection-AllApps-AnyPlatform-MFAandPWDforHighUserRisk"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]

    }

    client_app_types = ["all"]
    user_risk_levels = ["high"]


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.internals-IdentityProtection-exclusion.id]
    }





  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["passwordChange", "mfa"]
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
    client_app_types    = ["all"]
    sign_in_risk_levels = ["high"]


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.internals-IdentityProtection-exclusion.id]
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
    client_app_types    = ["exchangeActiveSync", "other"]
    sign_in_risk_levels = ["high"]


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.internals-IdentityProtection-exclusion.id]
    }
  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["block"]
  }

}

# Internals App and Data Protection

resource "azuread_conditional_access_policy" "CA205-Internals-AppProtection-MicrosoftIntuneEnrollment-AnyPlatform-MFA" {
  display_name = "CA205-Internals-AppProtection-MicrosoftIntuneEnrollment-AnyPlatform-MFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = [data.azuread_service_principal.intune.client_id]

    }
    platforms {
      included_platforms = ["all"]
    }
    client_app_types    = ["all"]
  


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.internals-AppProtection-exclusion.id]
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

resource "azuread_conditional_access_policy" "CA206-Internals-DataandAppProtection-AllApps-iOSorAndroid-ClientAppORAPP" {
  display_name = "CA206-Internals-DataandAppProtection-AllApps-iOSorAndroid-ClientAppORAPP"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["Office365"]
      excluded_applications = [data.azuread_service_principal.intune.client_id]

    }
    platforms {
      included_platforms = ["iOS", "android"]
    }
    client_app_types    = ["all"]
   


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.internals-DataProtection-exclusion.id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["approvedApplication", "compliantApplication"]
  }



}


resource "azuread_conditional_access_policy" "CA207-Internals-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUnknownPlatforms" {
  display_name = "CA207-Internals-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUnknownPlatforms"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]


    }
    platforms {
      included_platforms = ["all"]
      excluded_platforms = ["iOS", "windowsPhone", "macOS", "android", "windows"]
    }
    client_app_types = ["all"]



    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id,  azuread_group.Internals-AttackSurfaceReduction-Exclusions.id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }

}


## Externals Policies (CA300-399)

## The Externals are users in AD synced to Azure AD who are not employees, like a consultant. (A consultant may (also) be a guest account instead of an AD account). 

# Externals Base Protection


resource "azuread_conditional_access_policy" "CA300-Externals-BaseProtection-AllApps-AnyPlatform-CompliantorAADHJ" {
  display_name = "CA300-Externals-BaseProtection-AllApps-AnyPlatform-CompliantorAADHJ"
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
      included_groups = [azuread_group.externals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.externals-BaseProtection-exclusion.id]
    }
    client_app_types = ["all"]


  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["compliantDevice", "domainJoinedDevice"]
  }


}

resource "azuread_conditional_access_policy" "CA301-Externals-IdentityProtection-AllApps-AnyPlatform-CombinedRegistration" {

  display_name = "CA301-Externals-IdentityProtection-AllApps-AnyPlatform-CombinedRegistration"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_user_actions = ["urn:user:registersecurityinfo"]
    }
    platforms {
      included_platforms = ["all"]

    }

    locations {
      included_locations = ["all"]
    }


    users {
      included_groups = [azuread_group.externals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.externals-IdentityProtection-exclusion.id]
    }
    client_app_types = ["all"]


  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["compliantDevice", "domainJoinedDevice"]
  }
}

resource "azuread_conditional_access_policy" "CA302-Externals-IdentityProtection-AllApps-AnyPlatform-MFAandPWDforHighUserRisk" {
  display_name = "CA302-Externals-IdentityProtection-AllApps-AnyPlatform-MFAandPWDforHighUserRisk"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]

    }

    client_app_types = ["all"]
    user_risk_levels = ["high"]


    users {
      included_groups = [azuread_group.externals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.externals-IdentityProtection-exclusion.id]
    }





  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["passwordChange", "mfa"]
  }


}

resource "azuread_conditional_access_policy" "CA303-Externals-IdentityProtection-AllApps-AnyPlatform-MFAforHighSignInRisk" {
  display_name = "CA303-Externals-IdentityProtection-AllApps-AnyPlatform-MFAforHighSignInRisk"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]

    }
    platforms {
      included_platforms = ["all"]
    }
    client_app_types    = ["all"]
    sign_in_risk_levels = ["high"]


    users {
      included_groups = [azuread_group.externals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.externals-IdentityProtection-exclusion.id]
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

resource "azuread_conditional_access_policy" "CA304-Externals-IdentityProtection-AllApps-AnyPlatform-BlockLegacyAuth" {
  display_name = "CA304-Externals-IdentityProtection-AllApps-AnyPlatform-BlockLegacyAuth"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]

    }
    platforms {
      included_platforms = ["all"]
    }
    client_app_types    = ["exchangeActiveSync", "other"]
   


    users {
      included_groups = [azuread_group.internals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.externals-IdentityProtection-exclusion.id]
    }
  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["block"]
  }

}


## Externals App and Data Protection


resource "azuread_conditional_access_policy" "CA305-Externals-AppProtection-MicrosoftIntuneEnrollment-AnyPlatform-MFA" {
  display_name = "CA305-Externals-AppProtection-MicrosoftIntuneEnrollment-AnyPlatform-MFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = [data.azuread_service_principal.intune.client_id]

    }
    platforms {
      included_platforms = ["all"]
    }
    client_app_types    = ["all"]
    


    users {
      included_groups = [azuread_group.externals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.externals-AppProtection-exclusion.id]
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




resource "azuread_conditional_access_policy" "CA306-Externals-DataandAppProtection-AllApps-iOSorAndroid-ClientAppORAPP" {
  display_name = "CA306-Externals-DataandAppProtection-AllApps-iOSorAndroid-ClientAppORAPP"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["Office365"]
      excluded_applications = [data.azuread_service_principal.intune.client_id]

    }
    platforms {
      included_platforms = ["iOS", "android"]
    }
    client_app_types    = ["all"]
 


    users {
      included_groups = [azuread_group.externals.id]
      excluded_groups = [azuread_group.breakglass.id, azuread_group.externals-DataProtection-exclusion.id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["approvedApplication", "compliantApplication"]
  }



}

resource "azuread_conditional_access_policy" "CA307-Externals-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUnknownPlatforms" {
  display_name = "CA307-Externals-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUnknownPlatforms"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    applications {
      included_applications = ["All"]


    }
    platforms {
      included_platforms = ["all"]
      excluded_platforms = ["iOS", "windowsPhone", "macOS", "android", "windows"]
    }
    client_app_types = ["all"]



    users {
      included_groups = [azuread_group.externals.id]
      excluded_groups = [azuread_group.breakglass.id,  azuread_group.Externals-AttackSurfaceReduction-Exclusions.id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }

}
