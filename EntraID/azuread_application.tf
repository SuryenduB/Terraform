# resource "azuread_application" "bookings_api_application" {
    
#     display_name     = "bookings-api"
#     identifier_uris  = ["api://bookings"]
#     owners           = [data.azuread_client_config.current.object_id]

#     api {
#         requested_access_token_version = 2
#     }

#     required_resource_access {
#         resource_app_id = azuread_application.payments_api_application.client_id

#         resource_access {
#             id   = azuread_application.payments_api_application.app_role_ids["Reader"]
#             type = "Role"
#         }
#     }
# }



# resource "azuread_service_principal" "bookings_sp" {
#   client_id                    = azuread_application.bookings_api_application.client_id
#   app_role_assignment_required = false
#   owners                       = [data.azuread_client_config.current.object_id]
#   tags                         = ["bookings", "api"]
# }
