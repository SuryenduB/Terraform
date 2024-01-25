module "test_application" {
    source = "./modules/EntraIDApplication"

    display_name = "Test Application"
    identifier_uris = ["https://test-application"]
    sign_in_audience = "AzureADMyOrg"
    path_to_logo_image = "GCN3.png"
    app_roles = [
        {
            description = "Test Application Role"
            display_name = "Test Application"
            value = "TestApplication Role"
        }
    ]
    id_token = [
        {
            name = "Test"
            essential = true
            source = null
            additional_properties = null
        }
    ]
}
