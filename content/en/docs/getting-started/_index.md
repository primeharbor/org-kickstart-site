---
title: Getting Started
description: Prerequisites, bootstrapping, and first deployment.
weight: 2
---

This section walks you through getting Org Kickstart deployed into a new AWS account.

## Prerequisites

Before running Org Kickstart you need:

- **Terraform** >= 1.0 (< 2.0)
- **AWS CLI** configured with credentials for the Management (Payer) account
- An **S3 bucket** for Terraform remote state
- A few manual "artisanal" steps completed in the AWS console (see [Bootstrap](bootstrap/))

## Steps

1. Complete the [Bootstrap](bootstrap/) steps in the AWS Console
2. [Set up your local repository](setup-local-repo/) — copy the `local-deploy` sample, pin the
   module version, and create your `<env>.tfvars` / `<env>.tfbackend`
3. Initialize Terraform:
   ```bash
   make env=your-org tf-init
   ```
4. Create the Security Account first (required before full apply):
   ```bash
   terraform apply -var-file="your-org.tfvars" -target module.security_account
   ```
6. Deploy everything:
   ```bash
   make env=your-org tf-execute
   ```
   This runs `tf-plan` followed by `tf-apply` — saving the plan, applying it, and writing
   `output-your-org.json` to your state bucket.

For subsequent updates, use:
```bash
make env=your-org update
```

## Using with an Existing Organization

If you already have an AWS Organization, see [Importing an Existing Org](importing/) for guidance on
importing existing resources into Terraform state.

## Example tfvars

See the [Reference](../reference/) page for a full annotated example. The
[examples/local-deploy](https://github.com/primeharbor/org-kickstart/tree/0.3.1/examples/local-deploy)
directory in the repository contains a sample layout with a `Makefile`, backend config template,
and helper scripts for running Org Kickstart from your workstation. To pin to a specific release,
see [Releases](../releases/).
