---
title: Examples
description: Example configurations and the local-deploy sample layout.
date: 2025-01-01
weight: 3
---

## Local Deploy Sample

The [`examples/local-deploy`](https://github.com/primeharbor/org-kickstart/tree/0.3.1/examples/local-deploy)
directory contains a sample layout for managing your organization with Terraform from your
workstation via its `Makefile`. It shows how to structure your organization-specific configuration
(`<env>.tfvars`, `<env>.tfbackend`) alongside the module.

## Sample tfvars

See the [Example tfvars](getting-started/example-page/) page for a full annotated example
configuration file covering all major options.

## Policy Library

Ready-to-use policy files are available in the
[`policies/`](https://github.com/primeharbor/org-kickstart/tree/0.3.1/policies) directory:

- `DenyRootSCP.json` — Deny root user access
- `SecurityControlsSCP.json.tftpl` — Base security guardrails
- `DisableRegionsPolicy.json.tftpl` — Region restrictions
- `RCP_S3DataPerimeter.json.tftpl` — S3 data perimeter
- `EC2IMDSv2Enforce_DCP.json` — IMDSv2 enforcement
- And more...

## Importing an Existing Organization

See [Importing an Existing Organization](getting-started/importing/) for a step-by-step guide
on adopting Org Kickstart in an existing AWS Organization.
