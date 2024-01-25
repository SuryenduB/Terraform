
data "azuread_service_principal" "intune" {
  client_id = "754029bc-6a9e-4784-a59a-c7dfcd471361"
}
data "azuread_user" "Adele_user" {
  user_principal_name = "AdeleV@03z3s.onmicrosoft.com"
}


