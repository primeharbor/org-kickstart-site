---
date: 2026-06-20
title: Org Kickstart v0.3.0 Released
linkTitle: v0.3.0 Release
description: >
  A big release: newer AWS Organizations policy types, CloudFormation stacks,
  managed state bucket, declarative imports, the Account Configurator, and a
  documentation site.
author: '[Chris Farris](https://www.chrisfarris.com)'
draft: false
---

Org Kickstart **v0.3.0** is now available — the largest release yet. It adds the newest AWS
Organizations policy types, first-class CloudFormation deployment, a managed Terraform state
bucket, declarative resource adoption, the Account Configurator integration, and a full
documentation site at [aws-kickstart.org](https://aws-kickstart.org).

## New Features

- **Declarative & Resource Control Policies** — manage EC2 Declarative Policies (image/snapshot BPA,
  IMDSv2 enforcement) and RCPs alongside SCPs in one consistent, templatable structure.
- **CloudFormation everywhere** — a generic StackSet capability, plus `payer_cloudformation_stacks`
  and `security_account_stacks` to deploy arbitrary CloudFormation stacks (per-region) into the
  payer and security accounts directly from Terraform.
- **Managed state bucket** — `manage_state_bucket` (default on) adopts your existing
  `backend_bucket` and enforces versioning, public-access-block, and encryption, with
  `prevent_destroy` so it can't be deleted.
- **Declarative imports** — `examples/local-deploy/import.tf` adopts the Organization, payer
  account, and state bucket via `import` blocks, so a brand-new org no longer needs
  `scripts/import_org.sh` for the foundational resources.
- **Account Configurator** — optional [pht-account-configurator](https://github.com/primeharbor/pht-account-configurator)
  integration (git submodule + `make account-configurator`) to harden new accounts on creation.
  See the [docs](https://aws-kickstart.org/docs/account-configurator/).
- **DataTrails** — optional CloudTrail S3 data-event configuration ([PR #14](https://github.com/primeharbor/org-kickstart/pull/14)).
- **Budgets** — organizational and per-account AWS Budgets.
- **Security account parity** — a (now required) `security_account` block gives the security account
  the same configuration options as every other account.
- **Close-on-deletion**, **Personal Health Dashboard** delegated admin, and configurable
  `aws_service_access_principals` / `enabled_policy_types` exclusions (thanks
  [Ashex](https://github.com/Ashex)!).
- **Granted support** — generate an AWS config from your org outputs and share your repo as a
  [Granted Registry](https://aws-kickstart.org/docs/granted/).
- **Documentation site** — full setup, parameter reference, and guides at
  [aws-kickstart.org](https://aws-kickstart.org); the canonical sample now lives in
  `examples/local-deploy`.

## Breaking Changes

- **Security Account SSO delegation (major):** the Security Account is no longer assigned as
  Delegated Admin for IAM Identity Center by default, and a `security_account` block is now
  **required** in your tfvars. Apply SSO delegated admin there if you want it.
- **Policy module refactor (minor):** SCP/RCP/Declarative policies moved into a single
  `org_policies` module and attachments switched from `count` to `for_each`. Resources will be
  renamed/recreated unless you `terraform state mv` them — see the
  [full notes](https://github.com/primeharbor/org-kickstart/blob/0.3.0/docs/v0.3.0-notes.md) for the
  exact commands.

## Bug Fixes

- Added explicit `depends_on` to several Organizations resources (AI policy, RAM sharing, the
  SCP/RCP/Declarative modules, and the CUR report) that previously raced creation on a first apply.
- Fixed the `granted` Make target so it always runs and writes `granted/aws-config`.

## Releases & branch model

Going forward, **`latest` is the default working branch** — it always holds the newest changes.
Each release is a **frozen, tagged version** (like `0.3.0`); pin to one with
`source = "github.com/primeharbor/org-kickstart?ref=0.3.0"`.

We target **quarterly releases**, but may cut a new version sooner when significant new AWS
organization-management features warrant it. See the
[Releases](https://aws-kickstart.org/docs/releases/) page for details.

The [full v0.3.0 release notes](https://github.com/primeharbor/org-kickstart/blob/0.3.0/docs/v0.3.0-notes.md)
— including the security-services provider→region migration — are on GitHub.
