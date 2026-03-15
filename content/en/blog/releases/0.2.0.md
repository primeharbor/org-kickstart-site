---
title: Org Kickstart v0.2.0 Released
date: 2024-06-01
description: >
  Generic CloudFormation StackSets, organizational budgets, DataTrails, and more.
---

Org Kickstart v0.2.0 is now available with expanded account management capabilities and
several new optional features.

## New Features

- **Generic CloudFormation StackSet support** — Deploy arbitrary CloudFormation stacks to all accounts
- **Delegated Admin** — Account definitions can now specify which services the account is Delegated Admin for
- **Organizational Budget** — Set a total budget for the organization alongside per-account budgets
- **DataTrails** — Optional advanced CloudTrail with S3 data events
- **Personal Health Dashboard delegation** — Security Account receives PHD events from all accounts
- **Security Account parity** — Security Account now has feature parity with all other accounts
- **Account close-on-deletion** — Control whether accounts are closed when removed from Terraform state

## Breaking Changes

- A `security_account` block is now required in the tfvars file
- The Security Account is no longer automatically made Delegated Admin for IAM Identity Center

See the [full release notes](https://github.com/primeharbor/org-kickstart/blob/main/docs/v0.2.0-notes.md)
on GitHub.
