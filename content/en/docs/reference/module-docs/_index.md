---
title: Module Documentation
description: Auto-generated Terraform module reference — inputs, outputs, resources, and sub-modules.
weight: 20
---

{{< alert color="info" >}}
This page is auto-generated from the Terraform source in
[org-kickstart](https://github.com/primeharbor/org-kickstart).
Run `make generate-module-docs` in the `org-kickstart-site/` directory to refresh it.
{{< /alert >}}

<!-- BEGIN TERRAFORM-DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.80.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.80.0 |
| <a name="provider_aws.security-account"></a> [aws.security-account](#provider\_aws.security-account) | >= 5.80.0 |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_accounts"></a> [accounts](#module\_accounts) | ./modules/account | n/a |
| <a name="module_billing_alerts"></a> [billing\_alerts](#module\_billing\_alerts) | ./modules/billing_alerts | n/a |
| <a name="module_declarative_policies"></a> [declarative\_policies](#module\_declarative\_policies) | ./modules/declarative_policies | n/a |
| <a name="module_rcp"></a> [rcp](#module\_rcp) | ./modules/rcp | n/a |
| <a name="module_scp"></a> [scp](#module\_scp) | ./modules/scp | n/a |
| <a name="module_security_account"></a> [security\_account](#module\_security\_account) | ./modules/account | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_account_alternate_contact.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.operations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_primary_contact.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_primary_contact) | resource |
| [aws_cloudformation_stack.account_factory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack.audit_role_payer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack_set.audit_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.audit_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_cloudtrail.org_cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cur_report_definition.cur_report_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition) | resource |
| [aws_iam_organizations_features.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_organizations_features) | resource |
| [aws_iam_role.cloudtrail_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudtrail_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_identitystore_group.admin_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_group) | resource |
| [aws_kms_alias.macie_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.macie_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.macie_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_organizations_account.payer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_delegated_administrator.cloudformation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_delegated_administrator.securityhub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_delegated_administrator.sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.custom_ous](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.governance_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.sandbox_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.suspended_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.workloads_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_policy.ai_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy_attachment.ai_policy_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_s3_bucket.billing_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.declarative_policy_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.macie_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.vpc_flowlogs_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_ownership_controls.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.declarative_policy_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.macie_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.vpc_flowlogs_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.allow_billing_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.cloudtrail_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.declarative_policy_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.macie_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.vpc_flowlogs_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.cloudtrail_bucket_bpa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.declarative_policy_bucket_bpa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.macie_bucket_bpa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.vpc_flowlogs_bucket_bpa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.macie_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.declarative_policy_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.macie_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.vpc_flowlogs_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.account_factory_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_securityhub_account.payer_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_account.security_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_configuration_policy.no_enabled_standards](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_configuration_policy) | resource |
| [aws_securityhub_configuration_policy_association.root_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_configuration_policy_association) | resource |
| [aws_securityhub_finding_aggregator.regional_aggregator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_finding_aggregator) | resource |
| [aws_securityhub_organization_admin_account.delegated_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_admin_account) | resource |
| [aws_securityhub_organization_configuration.security_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_configuration) | resource |
| [aws_sns_topic.cloudtrail_s3_notification_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_ssoadmin_account_assignment.payer_account_group_assignment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_managed_policy_attachment.admin_policy_attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_managed_policy_attachment) | resource |
| [aws_ssoadmin_permission_set.admin_permission_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |
| [aws_billing_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/billing_service_account) | data source |
| [aws_iam_policy_document.allow_billing_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_s3_notification_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.declarative_policy_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.macie_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_flowlogs_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organizational_units.all_ous](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |
| [aws_regions.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |
| [aws_ssoadmin_instances.identity_store](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |
| [external_external.get_caller_identity](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_configurator"></a> [account\_configurator](#input\_account\_configurator) | n/a | `any` | `null` | no |
| <a name="input_accounts"></a> [accounts](#input\_accounts) | Account Index | `any` | n/a | yes |
| <a name="input_admin_group_name"></a> [admin\_group\_name](#input\_admin\_group\_name) | Name of the Identity Store Group with all the admin users | `string` | `"AllAdmins"` | no |
| <a name="input_admin_permission_set_name"></a> [admin\_permission\_set\_name](#input\_admin\_permission\_set\_name) | Name of the Permission Set to Create | `string` | `"AdministratorAccess"` | no |
| <a name="input_audit_role_name"></a> [audit\_role\_name](#input\_audit\_role\_name) | Name of the AuditRole to deploy | `string` | `"security-audit"` | no |
| <a name="input_audit_role_stack_set_template_url"></a> [audit\_role\_stack\_set\_template\_url](#input\_audit\_role\_stack\_set\_template\_url) | URL that points to the Audit Role Policy Template | `string` | `null` | no |
| <a name="input_backend_bucket"></a> [backend\_bucket](#input\_backend\_bucket) | n/a | `any` | n/a | yes |
| <a name="input_billing_alerts"></a> [billing\_alerts](#input\_billing\_alerts) | n/a | `any` | `null` | no |
| <a name="input_billing_data_bucket_name"></a> [billing\_data\_bucket\_name](#input\_billing\_data\_bucket\_name) | Name of the S3 Bucket for CUR reports. Set to null to disable | `string` | `null` | no |
| <a name="input_cloudtrail_bucket_name"></a> [cloudtrail\_bucket\_name](#input\_cloudtrail\_bucket\_name) | Name of the S3 Bucket to create to store CloudTrail events. Set to null to disable cloudtrail management | `string` | `null` | no |
| <a name="input_cloudtrail_loggroup_name"></a> [cloudtrail\_loggroup\_name](#input\_cloudtrail\_loggroup\_name) | Name of the CloudWatch Log Group in the payer account where CloudTrail will send its events | `string` | `null` | no |
| <a name="input_cur_report_frequency"></a> [cur\_report\_frequency](#input\_cur\_report\_frequency) | Frequency CUR reports should be delivered (DAILY, HOURLY, MONTHLY). Set to NONE to disable | `string` | `"NONE"` | no |
| <a name="input_declarative_policies"></a> [declarative\_policies](#input\_declarative\_policies) | Map of Declarative Policies to deploy | `map` | `{}` | no |
| <a name="input_declarative_policy_bucket_name"></a> [declarative\_policy\_bucket\_name](#input\_declarative\_policy\_bucket\_name) | Name of S3 Bucket for Declarative Policy Reports | `any` | `null` | no |
| <a name="input_deploy_audit_role"></a> [deploy\_audit\_role](#input\_deploy\_audit\_role) | Boolean to determine if org-kickstart should manage Audit Role | `bool` | `true` | no |
| <a name="input_disable_sso_management"></a> [disable\_sso\_management](#input\_disable\_sso\_management) | Set to true to manage AWS Identity Center outside of org-kickstart | `bool` | `false` | no |
| <a name="input_global_billing_contact"></a> [global\_billing\_contact](#input\_global\_billing\_contact) | Map for the central billing alternate contact to be applied to all accounts | `any` | `null` | no |
| <a name="input_global_operations_contact"></a> [global\_operations\_contact](#input\_global\_operations\_contact) | Map for the central operations alternate contact to be applied to all accounts | `any` | `null` | no |
| <a name="input_global_primary_contact"></a> [global\_primary\_contact](#input\_global\_primary\_contact) | Map for the primary account owner to be applied to all accounts | `any` | `null` | no |
| <a name="input_global_security_contact"></a> [global\_security\_contact](#input\_global\_security\_contact) | Map for the central security alternate contact to be applied to all accounts | `any` | `null` | no |
| <a name="input_macie_bucket_name"></a> [macie\_bucket\_name](#input\_macie\_bucket\_name) | Name of the S3 Bucket to create to store Macie Findings. Set to null to skip creation | `string` | `null` | no |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | Name of the Organization. This is used for resource prefixes and general reference | `string` | n/a | yes |
| <a name="input_organization_units"></a> [organization\_units](#input\_organization\_units) | Map of OUs to deploy | `map` | `{}` | no |
| <a name="input_payer_email"></a> [payer\_email](#input\_payer\_email) | Root Email address for the Organization Management account | `string` | `null` | no |
| <a name="input_payer_name"></a> [payer\_name](#input\_payer\_name) | Name of the Organization Management account | `string` | `"AWS Payer"` | no |
| <a name="input_resource_control_policies"></a> [resource\_control\_policies](#input\_resource\_control\_policies) | Map of RCPs to deploy | `map` | `{}` | no |
| <a name="input_security_account_name"></a> [security\_account\_name](#input\_security\_account\_name) | Name of the Security Account | `string` | `"Security Account"` | no |
| <a name="input_security_account_root_email"></a> [security\_account\_root\_email](#input\_security\_account\_root\_email) | Root Email address for the security account | `string` | `null` | no |
| <a name="input_security_services"></a> [security\_services](#input\_security\_services) | explictly disable or not manage a security service | `map` | <pre>{<br/>  "disable_guardduty": "false",<br/>  "disable_inspector": "false",<br/>  "disable_macie": "false",<br/>  "disable_securityhub": "false"<br/>}</pre> | no |
| <a name="input_service_control_policies"></a> [service\_control\_policies](#input\_service\_control\_policies) | Map of SCPs to deploy | `map` | `{}` | no |
| <a name="input_session_duration"></a> [session\_duration](#input\_session\_duration) | Default Session Duration | `string` | `"PT8H"` | no |
| <a name="input_tag_set"></a> [tag\_set](#input\_tag\_set) | Default map of tags to be applied to all resources via all providers | `map(any)` | `{}` | no |
| <a name="input_vpc_flowlogs_bucket_name"></a> [vpc\_flowlogs\_bucket\_name](#input\_vpc\_flowlogs\_bucket\_name) | Name of the S3 Bucket to create to store VPC Flow Logs. Set to null to skip creation | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudtrail_cloudwatch_log_group"></a> [cloudtrail\_cloudwatch\_log\_group](#output\_cloudtrail\_cloudwatch\_log\_group) | n/a |
| <a name="output_cloudtrail_s3_notification_topic"></a> [cloudtrail\_s3\_notification\_topic](#output\_cloudtrail\_s3\_notification\_topic) | n/a |
| <a name="output_declarative_policy_bucket"></a> [declarative\_policy\_bucket](#output\_declarative\_policy\_bucket) | n/a |
| <a name="output_macie_key_arn"></a> [macie\_key\_arn](#output\_macie\_key\_arn) | Things to pass to the Security Services Regional Modules |
| <a name="output_org_id"></a> [org\_id](#output\_org\_id) | n/a |
| <a name="output_org_name"></a> [org\_name](#output\_org\_name) | n/a |
| <a name="output_security_account_id"></a> [security\_account\_id](#output\_security\_account\_id) | n/a |
| <a name="output_sso_instance_arn"></a> [sso\_instance\_arn](#output\_sso\_instance\_arn) | AWS Identity Center Instance ARN managed by org-kickstart |
<!-- END TERRAFORM-DOCS -->
