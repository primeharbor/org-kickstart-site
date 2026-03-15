---
date: 2025-01-01
title: Org Kickstart v0.3.0 Released
linkTitle: v0.3.0 Release
description: >
  Declarative Policies, Resource Control Policies, Centralized Root Management, and more.
author: '[Chris Farris](https://www.chrisfarris.com)'
draft: true
---

Org Kickstart v0.3.0 is now available. This release adds support for the newest AWS
Organizations policy types and several quality-of-life improvements.

## New Features

- **Declarative Policies** — Manage EC2 Declarative Policies (image BPA, snapshot BPA, IMDSv2 enforcement)
- **Resource Control Policies** — Manage RCPs alongside SCPs in the same Terraform structure
- **Centralized Root Management** — Support for removing root credentials from member accounts
- **Audit Role from S3 or local** — The audit role StackSet template can now be sourced from S3 or a local file
- **Per-account primary contact override** — Each account can override the primary contact information
- **Improved GuardDuty** — Leverages new GuardDuty feature that auto-enables in existing accounts

## Changes to tfvars

- Add `audit_role_stack_set_template_url`
- Add `declarative_policy_bucket_name`
- Add `primary_contact` as an option on an account
- Add `declarative_policies` block
- Add `resource_control_policies` block

See the [full release notes](https://github.com/primeharbor/org-kickstart/blob/main/docs/v0.3.0-notes.md)
on GitHub.
