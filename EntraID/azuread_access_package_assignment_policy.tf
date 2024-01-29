# resource "azuread_access_package_assignment_policy" "all_applications" {
#   access_package_id = azuread_access_package.all_applications.id
#   display_name      = "Everyone can request"
#   description       = "Everyone can request"
#   duration_in_days  = 90

#   requestor_settings {
#     scope_type = "AllExistingDirectoryMemberUsers"
#   }

#   approval_settings {
#     approval_required = true

#     approval_stage {
#       approval_timeout_in_days = 14

#       primary_approver {
#         object_id    = azuread_group.security_groups["Group 1"].object_id
#         subject_type = "groupMembers"
#       }
#     }
#   }

#   assignment_review_settings {
#     enabled                        = true
#     review_frequency               = "weekly"
#     duration_in_days               = 3
#     review_type                    = "Self"
#     access_review_timeout_behavior = "keepAccess"
#   }
# }