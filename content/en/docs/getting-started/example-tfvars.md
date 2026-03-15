---
title: Example tfvars
description: A complete annotated example tfvars file.
weight: 4
---

The following is a complete example `tfvars` file showing all major configuration options.
Copy this as a starting point and customize for your organization.

```hcl
organization = {
  organization_name                 = "my-org"
  payer_name                        = "My Org Management Account"
  payer_email                       = "aws+payer@example.com"
  security_account_name             = "my-org-security"
  security_account_root_email       = "aws+security@example.com"
  cloudtrail_bucket_name            = "my-org-cloudtrail"
  cloudtrail_loggroup_name          = "CloudTrail/DefaultLogGroup"
  billing_data_bucket_name          = "my-org-cur"
  cur_report_frequency              = "DAILY"   # DAILY, HOURLY, or MONTHLY
  session_duration                  = "PT8H"
  admin_permission_set_name         = "AdministratorAccess"
  admin_group_name                  = "AllAdmins"
  disable_sso_management            = false
  deploy_audit_role                 = true
  audit_role_name                   = "security-audit"
  audit_role_stack_set_template_url = "https://s3.amazonaws.com/pht-cloudformation/aws-account-automation/AuditRole-Template.yaml"
  declarative_policy_bucket_name    = "my-org-account-status"
  vpc_flowlogs_bucket_name          = "my-org-flowlogs"
  macie_bucket_name                 = "my-org-macie-findings"

  # Custom OUs (in addition to the four required OUs)
  organization_units = {
    "Platform" = {
      name             = "Platform"
      is_child_of_root = true
    }
  }

  # AWS Accounts
  accounts = {
    dev = {
      account_name          = "my-org-dev"
      account_email         = "aws+dev@example.com"
      monthly_budget_amount = 500
    }

    prod = {
      account_name   = "my-org-prod"
      account_email  = "aws+prod@example.com"
      parent_ou_name = "Workloads"
    }

    sandbox = {
      account_name   = "my-org-sandbox"
      account_email  = "aws+sandbox@example.com"
      parent_ou_name = "Sandbox"
    }

    sso = {
      account_name    = "my-org-sso"
      account_email   = "aws+sso@example.com"
      parent_ou_name  = "Governance"
      delegated_admin = ["sso.amazonaws.com"]
    }
  }

  # Alternate contacts applied to all accounts (can be overridden per account)
  global_billing_contact = {
    name          = "Finance Team"
    title         = "CFO"
    email_address = "billing@example.com"
    phone_number  = "+14041234567"
  }

  global_security_contact = {
    name          = "Security Team"
    title         = "CISO"
    email_address = "security@example.com"
    phone_number  = "+14041234567"
  }

  global_primary_contact = {
    full_name       = "IT Operations"
    company_name    = "My Org, Inc."
    address_line_1  = "123 Main Street"
    city            = "Atlanta"
    state_or_region = "GA"
    postal_code     = "30332"
    country_code    = "US"
    email_address   = "aws@example.com"
    phone_number    = "+14041234567"
  }

  # Service Control Policies
  service_control_policies = {
    deny_root = {
      policy_name        = "DenyRoot"
      policy_description = "Denies use of root user"
      policy_json_file   = "policies/DenyRootSCP.json"
    }

    security_controls = {
      policy_name        = "DefaultSecurityControls"
      policy_description = "Base security controls for all accounts"
      policy_json_file   = "policies/SecurityControlsSCP.json.tftpl"
      policy_vars = {
        audit_role_name = "security-audit"
      }
    }
  }

  # Resource Control Policies
  resource_control_policies = {
    s3_data_perimeter = {
      policy_name        = "S3DataPerimeter"
      policy_description = "Restricts S3 to principals inside the org"
      policy_json_file   = "policies/RCP_S3DataPerimeter.json.tftpl"
      policy_vars = {
        org_id = "o-xxxxxxxxxxxx"
      }
    }
  }

  # Declarative Policies
  declarative_policies = {
    deny_public_ami = {
      policy_name        = "Block_Public_AMIs"
      policy_description = "Deny public sharing of all AMIs"
      policy_type        = "DECLARATIVE_POLICY_EC2"
      policy_json_file   = "policies/EC2ImageBPA_DCP.json"
      policy_targets     = ["Workloads", "Governance", "Sandbox"]
    }
  }

  # Security Services
  security_services = {
    disable_guardduty   = false
    disable_securityhub = false
    disable_macie       = false
  }

  # Billing Alerts
  billing_alerts = {
    levels = {
      level1  = 100
      level2  = 500
      oh_shit = 1000
    }
    subscriptions = ["billing-alerts@example.com"]
  }

  budget_defaults = {
    alert_recipients      = ["finance@example.com"]
    currency              = "USD"
    warning_percentage    = 80
    organizational_budget = 1000
  }
}

backend_bucket = "my-org-terraform-state-123456789012"
```

## Backend Config File

Create a `my-org.tfbackend` file alongside your tfvars:

```
bucket = "my-org-terraform-state-123456789012"
key    = "org-kickstart.tfstate"
region = "us-east-1"
```

Then initialize with:

```bash
terraform init -backend-config="my-org.tfbackend"
```
