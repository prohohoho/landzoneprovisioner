## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aduser"></a> [aduser](#module\_aduser) | git::git@github.com:CloudVendingMachine/terraform-azure-ad-user-module.git | n/a |
| <a name="module_landing-zone-deployment"></a> [landing-zone-deployment](#module\_landing-zone-deployment) | git::git@github.com:CloudVendingMachine/terraform-azure-landing-zone-deployment | n/a |
| <a name="module_win-vm-module-main"></a> [win-vm-module-main](#module\_win-vm-module-main) | git::git@github.com:CloudVendingMachine/terraform-azure-win-vm-module-main | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_type"></a> [backup\_type](#input\_backup\_type) | n/a | `string` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_company_short_name"></a> [company\_short\_name](#input\_company\_short\_name) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_environment_short_name"></a> [environment\_short\_name](#input\_environment\_short\_name) | n/a | `any` | n/a | yes |
| <a name="input_isdemo"></a> [isdemo](#input\_isdemo) | n/a | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_location_short_name"></a> [location\_short\_name](#input\_location\_short\_name) | n/a | `any` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `any` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
