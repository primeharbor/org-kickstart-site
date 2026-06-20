---
title: Parameter Reference
description: All Terraform variables for the Org Kickstart module.
date: 2025-01-01
---

All configuration is passed via the `organization` variable (an object type) and a few
top-level variables. Below are the key configuration parameters.

## Top-Level Variables

| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `organization` | object | Yes | Main configuration object (see below) |
| `backend_bucket` | string | Yes | S3 bucket name for Terraform state |

## Organization Object

### Core Identity

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `organization_name` | string | Yes | Short name for the organization |
| `payer_name` | string | Yes | Display name for the management account |
| `payer_email` | string | Yes | Root email of the management account |
| `security_account_name` | string | Yes | Display name for the security account |
| `security_account_root_email` | string | Yes | Root email for the new security account |

### State Bucket

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `manage_state_bucket` | bool | `true` | Manage the `backend_bucket` (the S3 bucket holding Terraform state) with Terraform. The bucket must already exist; it is adopted via an `import` block in the calling module (see `examples/pipeline/main.tf`), and Terraform then enforces versioning, public-access-block, and AES256 encryption on it. It is protected with `prevent_destroy`. Set to `false` to leave the bucket unmanaged. |

### CloudTrail

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `cloudtrail_bucket_name` | string | required | S3 bucket for CloudTrail logs. Set `null` to disable |
| `cloudtrail_loggroup_name` | string | `"CloudTrail/DefaultLogGroup"` | CloudWatch Log Group name |

### SSO / Identity Center

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `session_duration` | string | `"PT8H"` | ISO 8601 duration for SSO sessions |
| `admin_permission_set_name` | string | `"AdministratorAccess"` | Name of the admin Permission Set |
| `admin_group_name` | string | `"AllAdmins"` | Name of the admin Identity Center group |
| `disable_sso_management` | bool | `false` | Set `true` to stop Terraform from managing SSO |
| `sso_instance_region` | string | `"us-east-1"` | Region where the IAM Identity Center instance is configured |
| `sso_start_url` | string | required when SSO is managed | AWS access portal URL, e.g. `https://yourorg.awsapps.com/start` |

### Audit Role

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `deploy_audit_role` | bool | `true` | Deploy the cross-account audit role StackSet |
| `audit_role_name` | string | `"security-audit"` | Name of the audit role in each account |
| `audit_role_stack_set_template_url` | string | required if deploy | S3 URL to the CloudFormation template |

### Billing

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `billing_data_bucket_name` | string | Yes | S3 bucket for CUR reports |
| `cur_report_frequency` | string | `"DAILY"` | `DAILY`, `HOURLY`, `MONTHLY`, or `"NONE"` to disable |
| `declarative_policy_bucket_name` | string | Yes | S3 bucket for declarative policy documents |

### Security Services

Configure which security services to enable/disable (each defaults to `false`):

```hcl
security_services = {
  disable_guardduty   = false
  disable_macie       = false
  disable_inspector   = false
  disable_securityhub = false
  disable_stacksets   = false
}
```

### Log & Findings Buckets

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `vpc_flowlogs_bucket_name` | string | `null` | S3 bucket to create for VPC Flow Logs. `null` to skip |
| `macie_bucket_name` | string | `null` | S3 bucket to create for Macie findings. `null` to skip |

### Organization Services & Policy Types

org-kickstart enables an opinionated set of AWS service-access principals and organization policy types. Adjust the defaults with:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `aws_service_access_principals_to_enable` | list(string) | `[]` | Extra service principals to enable beyond the default set |
| `aws_service_access_principals_to_exclude` | list(string) | `[]` | Service principals to remove from the default set |
| `organization_policy_types_to_exclude` | list(string) | `[]` | Org policy types to exclude from the default set (e.g. when a partition doesn't support one) |

### Account Configurator

Optional integration with [pht-account-configurator](https://github.com/primeharbor/pht-account-configurator) to harden new accounts on creation — see the [Account Configurator](../../account-configurator/) guide. Set the `account_configurator` object, or omit it to disable:

| Field | Type | Description |
|-------|------|-------------|
| `template` | string | S3 URL of the packaged configurator CloudFormation template |
| `account_factory_config_file` | string | Path (relative to repo root) to the YAML config file; Terraform uploads it to the state bucket |

### DataTrail

Optional [DataTrail](https://github.com/primeharbor/org-kickstart/pull/14) (CloudTrail S3 data-event) configuration in the security account. Set the `datatrail` object, or omit it to disable:

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `bucket_name` | string | required | S3 bucket holding the DataTrail logs |
| `trail_name` | string | required | Name of the CloudTrail data-event trail |
| `enabled` | bool | `true` | Whether the trail is enabled |
| `excluded_buckets` | list(string) | required | S3 buckets to exclude from data-event logging |

### Organizational Units

Four OUs are always created: `Governance`, `Workloads`, `Sandbox`, `Suspended`.
Additional OUs can be defined:

```hcl
organization_units = {
  "MyOU" = {
    name             = "MyOU"
    is_child_of_root = true
  }
  "NestedOU" = {
    name         = "NestedOU"
    parent_id    = "MyOU"   # use parent OU name for direct children of custom OUs
  }
}
```

### Accounts

Each account in the `accounts` map:

```hcl
accounts = {
  my_account = {
    account_name          = "my-org-prod"        # AWS account display name
    account_email         = "aws+prod@example.com" # root email (must be unique)
    parent_ou_name        = "Workloads"           # OU name (or use parent_ou_id)
    monthly_budget_amount = 1000                  # optional, in USD
    delegated_admin       = ["service.amazonaws.com"]  # optional

    # Optional: override primary contact for this account
    primary_contact = {
      full_name       = "Account Owner"
      company_name    = "My Org"
      address_line_1  = "123 Main St"
      city            = "Atlanta"
      state_or_region = "GA"
      postal_code     = "30332"
      country_code    = "US"
      email_address   = "owner@example.com"
      phone_number    = "+14041234567"
    }
  }
}
```

The org-wide `default_close_on_deletion` (bool, default `false`) controls whether an account is
**closed** — not just removed from the org — when it leaves org-kickstart. Use with caution.

### Security Account

The security account is created and managed like a workload account, but its settings live in a
dedicated **required** `security_account` block. Its name and root email come from
`security_account_name` / `security_account_root_email`; everything else is optional:

```hcl
security_account = {
  delegated_admin         = ["guardduty.amazonaws.com"]  # services it is delegated admin for
  monthly_budget_amount   = 100                          # optional, USD
  budget_alert_recipients = ["security@example.com"]     # optional
  # operations_contact and primary_contact may also be set (same shape as an account entry)
}
```

### Alternate Contacts

Applied org-wide (overridable per account):

```hcl
global_billing_contact = {
  name          = "Name"
  title         = "CFO"
  email_address = "billing@example.com"
  phone_number  = "+1xxxxxxxxxx"
}

global_security_contact = {
  name          = "Name"
  title         = "CISO"
  email_address = "security@example.com"
  phone_number  = "+1xxxxxxxxxx"
}

global_operations_contact = {
  name          = "Name"
  title         = "VP Engineering"
  email_address = "ops@example.com"
  phone_number  = "+1xxxxxxxxxx"
}

global_primary_contact = {
  full_name       = "Name"
  company_name    = "My Org"
  address_line_1  = "123 Main St"
  city            = "Atlanta"
  state_or_region = "GA"
  postal_code     = "30332"
  country_code    = "US"
  email_address   = "aws@example.com"
  phone_number    = "+1xxxxxxxxxx"
}
```

### Policies

All three policy types follow the same structure:

```hcl
service_control_policies = {
  my_policy = {
    policy_name        = "MyPolicy"
    policy_description = "Description"
    policy_json_file   = "policies/MyPolicy.json"
    policy_targets     = ["Workloads", "ou-xxxx-xxxxxxxx"]  # OU names or IDs
    policy_vars = {                                         # for .tftpl files
      variable_name = "value"
    }
  }
}
```

The same structure applies to `resource_control_policies` and `declarative_policies`
(which also require `policy_type = "DECLARATIVE_POLICY_EC2"`).

### Billing Alerts

```hcl
billing_alerts = {
  levels = {
    level1  = 100   # USD threshold
    level2  = 500
    oh_shit = 1000
  }
  subscriptions = ["email@example.com"]
}

budget_defaults = {
  alert_recipients      = ["email@example.com"]
  currency              = "USD"
  warning_percentage    = 80
  organizational_budget = 1000
}
```

### Payer CloudFormation Stacks

`payer_cloudformation_stacks` deploys arbitrary CloudFormation stacks into the
payer (management) account. It's the right hook for things like billing
notifications, payer-scoped cost-explorer alarms, or other automation that has
to live in the payer because of where billing data and Organizations APIs are
exposed.

Each map entry creates one stack per region listed. The Terraform resource
addresses use a `<key>-<region>` composite, so adding a region later does not
rename existing stacks.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `stack_name` | string | required | CloudFormation stack name |
| `template_file` | string | conditional | Local path to template, relative to the caller's `path.root`. Exactly one of `template_file` or `template_url` is required |
| `template_url` | string | conditional | HTTPS/S3 URL to the template. Exactly one of `template_file` or `template_url` is required |
| `regions` | list(string) | base org-kickstart region | Regions to deploy the stack into |
| `parameters` | map(string) | `{}` | CloudFormation parameter values |
| `timeout_in_minutes` | number | `15` | Stack create/update timeout |
| `on_failure` | string | `"DO_NOTHING"` | One of `DO_NOTHING`, `ROLLBACK`, `DELETE` |

All stacks are created with the full set of CloudFormation capabilities
(`CAPABILITY_IAM`, `CAPABILITY_NAMED_IAM`, `CAPABILITY_AUTO_EXPAND`).

```hcl
payer_cloudformation_stacks = {
  billing_alerts = {
    stack_name    = "slack_billing_alerts"
    template_file = "cloudformation/slack-Template.yaml"
    regions       = ["us-east-1"]
    parameters = {
      pExecutionRate = "cron(0 09 * * ? *)"
      # JSON-valued parameters can be written as heredocs. The module
      # canonicalizes any value that parses as JSON, so multi-line
      # formatting does not cause drift on subsequent plans.
      pEventInput = <<-EOT
        {
          "threshold": "10",
          "alert_percent": "20"
        }
      EOT
      pSlackWebhookSecret = "SlackWebHook"
      pRuleState          = "ENABLED"
      pAccountDescription = "My-Payer"
    }
  }
}
```

### Security Account Stacks

`security_account_stacks` is the same idea as `payer_cloudformation_stacks`,
but the stacks are deployed into the Security Account via the
`OrganizationAccountAccessRole`. Use it for security-scoped automation that
needs to live in the delegated-admin account: Security Hub finding processors,
GuardDuty event handlers, KMS keys for security data, ChatBot integrations,
and similar.

Schema, defaults, composite-key behavior, capabilities, and JSON parameter
canonicalization are identical to `payer_cloudformation_stacks`.

```hcl
security_account_stacks = {
  findings_processor = {
    stack_name    = "security-findings-processor"
    template_file = "cloudformation/findings-processor-Template.yaml"
    regions       = ["us-east-1"]
    parameters = {
      pSlackWebhookSecret = "SlackWebHook"
      pSeverityThreshold  = "MEDIUM"
    }
  }
}
```
