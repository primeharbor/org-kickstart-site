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
2. Copy [`examples/pipeline`](https://github.com/primeharbor/org-kickstart/tree/main/examples/pipeline)
   to your own private repo — it includes the `Makefile`, backend config, and directory layout
3. Create `your-org.tfvars` and `your-org.tfbackend` for your organization
   (see the [Reference](../reference/) for all variables; name them to match your `env` value)
4. Initialize Terraform:
   ```bash
   make env=your-org tf-init
   ```
5. Create the Security Account first (required before full apply):
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
[examples/pipeline](https://github.com/primeharbor/org-kickstart/tree/main/examples/pipeline)
directory in the repository contains a sample private-repo layout with a `Makefile`, backend config
template, and scripts for CI/CD deployments.
