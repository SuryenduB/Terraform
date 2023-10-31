data "azuread_client_config" "current" {}

data "azuread_application" "intune" {
  display_name = "Microsoft Intune Enrollment"
}
