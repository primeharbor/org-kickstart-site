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

Configure which security services to enable/disable:

```hcl
security_services = {
  disable_guardduty   = false
  disable_securityhub = false
  disable_macie       = false
}
```

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
    close_on_deletion     = false                 # optional

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
