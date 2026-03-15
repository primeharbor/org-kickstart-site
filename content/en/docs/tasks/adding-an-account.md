---
title: Adding a New Account
description: How to add a new AWS account to your organization.
weight: 1
---

Adding a new AWS account is the most common operation in Org Kickstart. All account configuration
lives in the `accounts` map in your tfvars file.

## Steps

1. Add an entry to the `accounts` map in your tfvars file:

   ```hcl
   accounts = {
     # ... existing accounts ...

     my_new_account = {
       account_name  = "my-org-new-account"
       account_email = "aws+new-account@example.com"
       parent_ou_name = "Workloads"
       monthly_budget_amount = 500
     }
   }
   ```

2. Plan and apply:

   ```bash
   make env=your-org tf-execute
   ```

   Or step-by-step to review the plan before applying:

   ```bash
   make env=your-org tf-plan
   make env=your-org tf-show
   make env=your-org tf-apply
   ```

Org Kickstart will create the AWS account, place it in the correct OU, assign SSO access,
set alternate contacts, and apply any policies that target the parent OU.

## Account Options

| Option | Description |
|--------|-------------|
| `account_name` | Display name for the AWS account |
| `account_email` | Root email address (must be globally unique) |
| `parent_ou_name` | Place the account in this OU (by name) |
| `parent_ou_id` | Place the account in this OU (by ID) |
| `monthly_budget_amount` | Budget alert threshold in USD |
| `delegated_admin` | List of AWS services to delegate admin for |
| `close_on_deletion` | Whether to close the account when removed from Terraform |
| `primary_contact` | Override the global primary contact for this account |

## Notes

- The `account_email` must be unique across all AWS accounts globally
- New accounts are created by AWS Organizations and may take a few minutes to become available
- The Security Account is managed separately via the `security_account` block
