---
title: Importing an Existing Organization
description: How to adopt Org Kickstart into an existing AWS Organization.
weight: 3
---

Org Kickstart can manage an existing AWS Organization. Several resources must be imported into
Terraform state before running `terraform apply`.

The minimum required imports are the **organization**, the **management account**, and the
**Security Account** (if it already exists). You may also want to import existing accounts,
CloudTrail buckets, billing buckets, and SSO configuration.

## Automated Import

The `scripts/import_org.sh` script generates an `import-org.tf` file and a TFVars snippet for
your existing accounts.

```bash
# From the org-kickstart directory
./scripts/import_org.sh
```

Review the generated `import-org.tf` carefully before running Terraform.

## Steps

1. Run `import_org.sh` and review `import-org.tf`
2. Add your CloudTrail or billing bucket to the import file if applicable
3. Review SCPs you want to import:
   ```bash
   aws organizations list-policies --filter SERVICE_CONTROL_POLICY \
     --query 'Policies[].[Id,Name]' --output text
   ```
4. Iterate with `tf-plan` until no unwanted changes appear:
   ```bash
   make env=your-org tf-plan
   make env=your-org tf-show    # review the plan output
   ```
5. Once satisfied, apply:
   ```bash
   make env=your-org tf-apply
   ```
6. Incrementally enable additional features

## Manual Import Examples

### Organizational Units

```bash
ROOT_OU=$(aws organizations list-roots --query Roots[0].Id --output text)
aws organizations list-organizational-units-for-parent \
  --parent-id $ROOT_OU \
  --query 'OrganizationalUnits[].[Id,Name]' --output text
```

```hcl
import {
  to = module.organization.aws_organizations_organizational_unit.TF_VARS_KEY
  id = "ou-xxxx-xxxxxxxx"
}
```

### IAM Identity Center (SSO)

To opt out of managing an existing Identity Center, set `disable_sso_management = true` in your
tfvars. This is recommended for existing orgs with complex SSO configurations.

```bash
IDENTITY_STORE_ID=$(aws sso-admin list-instances \
  --query Instances[0].IdentityStoreId --output text)
SSO_INSTANCE_ARN=$(aws sso-admin list-instances \
  --query Instances[0].InstanceArn --output text)
```

```hcl
import {
  to = module.organization.aws_identitystore_group.admin_group
  id = "$IDENTITY_STORE_ID/$GROUP_ID"
}
import {
  to = module.organization.aws_ssoadmin_permission_set.admin_permission_set
  id = "$PERMISSION_SET_ARN,$SSO_INSTANCE_ARN"
}
import {
  to = module.organization.aws_ssoadmin_managed_policy_attachment.admin_policy_attachments
  id = "arn:aws:iam::aws:policy/AdministratorAccess,$PERMISSION_SET_ARN,$SSO_INSTANCE_ARN"
}
```

### CloudTrail

```bash
aws cloudtrail list-trails --query Trails[].TrailARN --output text
```

```hcl
import {
  to = module.organization.aws_s3_bucket.cloudtrail_bucket[0]
  id = "YOUR_EXISTING_BUCKET_NAME"
}
import {
  to = module.organization.aws_cloudtrail.org_cloudtrail[0]
  id = "TRAIL_ARN"
}
```

### Service Control Policies

```bash
aws organizations list-policies --filter SERVICE_CONTROL_POLICY \
  --query 'Policies[].[Id,Name]' --output text

# Get OUs targeted by a policy
aws organizations list-targets-for-policy --policy-id p-xxxxxx
```

```hcl
import {
  to = module.organization.module.scp["POLICY_BLOCK_IDENTIFIER_FROM_TFVARS"].aws_organizations_policy.org_policy
  id = "p-xxxxxx"
}
```

## Disabling Features for Initial Import

When importing an existing org, you may want to temporarily disable features to prevent
unintended changes on the first apply:

- **CloudTrail**: `cloudtrail_bucket_name = null`
- **SSO**: `disable_sso_management = true`
- **Audit Role StackSet**: `deploy_audit_role = false`
- **Security Services**: use the `security_services` block with `disable_*` flags
