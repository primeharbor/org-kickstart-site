---
title: Creating Policies
description: How to create and attach SCPs, RCPs, and Declarative Policies.
weight: 2
---

Org Kickstart manages three types of AWS Organizations policies via the same Terraform pattern:
**Service Control Policies (SCPs)**, **Resource Control Policies (RCPs)**, and
**Declarative Policies**.

## Steps

1. Create a policy JSON file in the `policies/` directory of your deployment repo.
   For dynamic values, use a `.tftpl` extension and Terraform template syntax.

   ```json
   // policies/MyPolicy.json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Deny",
         "Action": "s3:DeleteBucket",
         "Resource": "*"
       }
     ]
   }
   ```

2. Add the policy definition to the appropriate block in your tfvars file:

   ```hcl
   service_control_policies = {
     deny_s3_delete = {
       policy_name        = "DenyS3BucketDeletion"
       policy_description = "Prevent deletion of S3 buckets"
       policy_json_file   = "policies/MyPolicy.json"
       policy_targets     = ["Workloads", "Sandbox"]
     }
   }
   ```

3. Plan and apply:

   ```bash
   make env=your-org tf-execute
   ```

   SCPs and RCPs are high-impact changes. Always review the plan before applying:

   ```bash
   make env=your-org tf-plan
   make env=your-org tf-show
   make env=your-org tf-apply
   ```

   You can also run a security scan of the plan with [Checkov](https://www.checkov.io/) before applying:

   ```bash
   make env=your-org checkov
   ```

## Policy Types

| Block | AWS Type |
|-------|----------|
| `service_control_policies` | Service Control Policy (SCP) |
| `resource_control_policies` | Resource Control Policy (RCP) |
| `declarative_policies` | Declarative Policy (EC2) |

Declarative Policies also require `policy_type = "DECLARATIVE_POLICY_EC2"`.

## Targeting OUs

`policy_targets` accepts a list of OU names or OU IDs. Use `"Root"` to target the
organization root:

```hcl
policy_targets = ["Root"]                          # all accounts
policy_targets = ["Workloads", "Sandbox"]          # by name
policy_targets = ["ou-xxxx-xxxxxxxx"]             # by ID
```

## Templated Policies

For policies that need org-specific values, use a `.tftpl` file:

```json
// policies/AuditRoleProtection.json.tftpl
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Deny",
    "Action": ["iam:Delete*"],
    "Resource": "arn:aws:iam::*:role/${audit_role_name}"
  }]
}
```

```hcl
service_control_policies = {
  protect_audit_role = {
    policy_name      = "ProtectAuditRole"
    policy_json_file = "policies/AuditRoleProtection.json.tftpl"
    policy_vars = {
      audit_role_name = "security-audit"
    }
  }
}
```

## Sample Policies

See the [`policies/`](https://github.com/primeharbor/org-kickstart/tree/main/policies) directory
in the repository for a library of ready-to-use policies. Or check out [PrimeHarbor's respository of Organizational Policies](https://github.com/primeharbor/aws-organizational-policies).
