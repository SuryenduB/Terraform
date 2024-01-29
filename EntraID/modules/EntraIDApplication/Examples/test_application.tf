module "test_application" {
  source = "../../modules/EntraIDApplication"

  display_name       = "Test Application"
  identifier_uris    = ["https://test-application"]
  sign_in_audience   = "AzureADMyOrg"
  path_to_logo_image = "GCN3.png"
  app_roles = [
    {
      description  = "Test Application Role"
      display_name = "Test Application"
      value        = "TestApplication Role"
    },
    {
      description  = "Test Application Role2"
      display_name = "Test Application Role 2"
      value        = "TestApplicationRole2"
    }
  ]
  app_role_assignment_required  = true
  description                   = "Test Application Description"
  preferred_single_sign_on_mode = "saml"
  claims_mapping_policy = {
    claims_schema = [
      {
        id              = "id"
        jwt_claim_type  = "name"
        Saml_Claim_Type = "name"
        source          = "user"
      }
    ]
    include_basic_claim_set = "true"
    version                 = "1"
  }

  generate_certificate                               = false
  generate_secret                                    = false
  generate_catalog_access_package                    = true
  approver_group_name                                = "Assigned Group"
  access_package_assignment_policy_approval_required = true
  object_owner_upn = "SuryenduB@03z3s.onmicrosoft.com"

}

output "azuread_application_group" {
  value = module.test_application.application_group

}

output "access_package" {
  value = module.test_application.access_package
}

output "access_package_resource" {
  value = module.test_application.azuread_access_package_resource_package_association

}
