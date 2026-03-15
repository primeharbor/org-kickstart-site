---
title: Reference
description: Variable reference, policy library, and module documentation.
weight: 9
---

This section contains low-level reference documentation for Org Kickstart.

## In This Section

- **[Parameter Reference](parameter-reference/)** — All Terraform variables and their defaults
- **[Module Documentation](module-docs/)** — Auto-generated resource and module reference

## Source

The complete module documentation is generated from the Terraform source and available in the
[ModuleDocs.md](https://github.com/primeharbor/org-kickstart/blob/main/ModuleDocs.md) file in
the repository.

## Policy Library

Sample policies are included in the [`policies/`](https://github.com/primeharbor/org-kickstart/tree/main/policies)
directory of the repository:

| File | Type | Description |
|------|------|-------------|
| `DenyRootSCP.json` | SCP | Deny use of root user in all accounts |
| `SecurityControlsSCP.json.tftpl` | SCP | Base security controls (requires `audit_role_name`) |
| `DisableRegionsPolicy.json.tftpl` | SCP | Restrict to approved AWS regions |
| `DenyUnapprovedInstanceTypes.json` | SCP | Deny non-approved EC2 instance types |
| `DenyUnapprovedServices.json` | SCP | Deny unapproved AWS services |
| `SuspendedAccountsPolicy.json.tftpl` | SCP | Deny all activity in suspended accounts |
| `RCP_S3DataPerimeter.json.tftpl` | RCP | Restrict S3 access to org principals |
| `EC2ImageBPA_DCP.json` | Declarative | Block public sharing of AMIs |
| `EC2SnapshotBPA_DCP.json` | Declarative | Block public sharing of EBS snapshots |
| `EC2IMDSv2Enforce_DCP.json` | Declarative | Enforce IMDSv2 with hop limit of 2 |

Policies with the `.tftpl` extension support Terraform template variables via `policy_vars`.
