# terraform-azuread-application

Use this Repository to onboard new applications successfully to Azure AD and add credentials to the application, add additional application roles and assign them to groups, create access packages with the necessary assignment policy to assign the application roles to Tenant users.
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 0.13.0)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (~> 2.15.0)

## Providers

The following providers are used by this module:

- <a name="provider_azuread"></a> [azuread](#provider\_azuread) (~> 2.15.0)

- <a name="provider_random"></a> [random](#provider\_random)

- <a name="provider_time"></a> [time](#provider\_time)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azuread_access_package.application_roles](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package) (resource)
- [azuread_access_package_assignment_policy.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_assignment_policy) (resource)
- [azuread_access_package_catalog.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_catalog) (resource)
- [azuread_access_package_resource_catalog_association.example_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_resource_catalog_association) (resource)
- [azuread_access_package_resource_package_association.azuread_access_package_resource_catalog_association](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_resource_package_association) (resource)
- [azuread_app_role_assignment.example_administer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) (resource)
- [azuread_application.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) (resource)
- [azuread_application_api_access.example_msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_api_access) (resource)
- [azuread_application_app_role.example_administer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_app_role) (resource)
- [azuread_application_optional_claims.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_optional_claims) (resource)
- [azuread_claims_mapping_policy.my_policy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/claims_mapping_policy) (resource)
- [azuread_group.example_administer_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_service_principal.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) (resource)
- [azuread_service_principal_certificate.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_certificate) (resource)
- [azuread_service_principal_claims_mapping_policy_assignment.app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_claims_mapping_policy_assignment) (resource)
- [azuread_service_principal_password.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) (resource)
- [random_uuid.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [time_rotating.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) (resource)
- [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) (data source)
- [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) (data source)
- [azuread_group.example_approver_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) (data source)
- [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) (data source)
- [azuread_user.owner](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_display_name"></a> [display\_name](#input\_display\_name)

Description: The display name of the application.

Type: `string`

### <a name="input_identifier_uris"></a> [identifier\_uris](#input\_identifier\_uris)

Description: The identifier URIs of the application.

Type: `list(string)`

### <a name="input_object_owner_upn"></a> [object\_owner\_upn](#input\_object\_owner\_upn)

Description: The UPN of the object owner.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_access_package_assignment_policy_approval_required"></a> [access\_package\_assignment\_policy\_approval\_required](#input\_access\_package\_assignment\_policy\_approval\_required)

Description: Whether approval is required for access package assignment policy.

Type: `bool`

Default: `false`

### <a name="input_access_package_assignment_policy_duration_in_days"></a> [access\_package\_assignment\_policy\_duration\_in\_days](#input\_access\_package\_assignment\_policy\_duration\_in\_days)

Description: The duration in days for access package assignment policy.

Type: `number`

Default: `14`

### <a name="input_access_token"></a> [access\_token](#input\_access\_token)

Description: The access token configuration.

Type:

```hcl
list(object({
    name                  = string
    essential             = bool
    source                = string
    additional_properties = list(string)
  }))
```

Default: `null`

### <a name="input_app_role_assignment_required"></a> [app\_role\_assignment\_required](#input\_app\_role\_assignment\_required)

Description: Whether app role assignment is required.

Type: `bool`

Default: `true`

### <a name="input_app_roles"></a> [app\_roles](#input\_app\_roles)

Description: The app roles of the application.

Type:

```hcl
list(object({
    description  = string
    display_name = string
    value        = string
  }))
```

Default: `[]`

### <a name="input_approver_group_name"></a> [approver\_group\_name](#input\_approver\_group\_name)

Description: The name of the approver group for access package assignment policy.

Type: `string`

Default: `"Administrators"`

### <a name="input_claims_mapping_policy"></a> [claims\_mapping\_policy](#input\_claims\_mapping\_policy)

Description: The claims mapping policy for the application.

Type:

```hcl
object({
    claims_schema           = list(object({
      id              = string
      jwt_claim_type  = string
      Saml_Claim_Type = string
      source          = string
    }))
    include_basic_claim_set = string
    version                 = number
  })
```

Default: `null`

### <a name="input_description"></a> [description](#input\_description)

Description: The description of the application.

Type: `string`

Default: `null`

### <a name="input_generate_catalog_access_package"></a> [generate\_catalog\_access\_package](#input\_generate\_catalog\_access\_package)

Description: Whether to generate a catalog access package for the application.

Type: `bool`

Default: `false`

### <a name="input_generate_certificate"></a> [generate\_certificate](#input\_generate\_certificate)

Description: Whether to generate a certificate for the application.

Type: `bool`

Default: `false`

### <a name="input_generate_secret"></a> [generate\_secret](#input\_generate\_secret)

Description: Whether to generate a secret for the application.

Type: `bool`

Default: `false`

### <a name="input_id_token"></a> [id\_token](#input\_id\_token)

Description: The ID token configuration.

Type:

```hcl
list(object({
    name                  = string
    essential             = bool
    source                = string
    additional_properties = list(string)
  }))
```

Default: `null`

### <a name="input_path_to_logo_image"></a> [path\_to\_logo\_image](#input\_path\_to\_logo\_image)

Description: The path to the logo image of the application.

Type: `string`

Default: `null`

### <a name="input_preferred_single_sign_on_mode"></a> [preferred\_single\_sign\_on\_mode](#input\_preferred\_single\_sign\_on\_mode)

Description: The preferred single sign-on mode.

Type: `string`

Default: `"notSupported"`

### <a name="input_relay_state"></a> [relay\_state](#input\_relay\_state)

Description: The relay state for single sign-on.

Type: `string`

Default: `null`

### <a name="input_saml2_token"></a> [saml2\_token](#input\_saml2\_token)

Description: The SAML2 token configuration.

Type:

```hcl
list(object({
    name                  = string
    essential             = bool
    source                = string
    additional_properties = list(string)
  }))
```

Default: `null`

### <a name="input_sign_in_audience"></a> [sign\_in\_audience](#input\_sign\_in\_audience)

Description: The sign-in audience of the application.

Type: `string`

Default: `"AzureADMyOrg"`

## Outputs

The following outputs are exported:

### <a name="output_access_package"></a> [access\_package](#output\_access\_package)

Description: The access package associated with the application.

### <a name="output_application_group"></a> [application\_group](#output\_application\_group)

Description: The Azure AD group associated with the application.

### <a name="output_azuread_access_package_resource_package_association"></a> [azuread\_access\_package\_resource\_package\_association](#output\_azuread\_access\_package\_resource\_package\_association)

Description: The association between the access package and the resource package in Azure AD.