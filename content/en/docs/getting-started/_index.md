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
2. Clone or reference the module from the [Terraform Registry](https://registry.terraform.io/modules/primeharbor/org-kickstart)
3. Create a `tfvars` file for your organization (see the [Reference](../reference/) for all variables)
4. Initialize Terraform with your state backend:
   ```bash
   terraform init -backend-config="your-org.tfbackend"
   ```
5. Create the Security Account first:
   ```bash
   terraform apply -var-file="your-org.tfvars" -target module.security_account
   ```
6. Apply the rest of the configuration:
   ```bash
   terraform plan -var-file="your-org.tfvars" -out=your-org.tfplan
   terraform apply your-org.tfplan
   ```

## Using with an Existing Organization

If you already have an AWS Organization, see [Importing an Existing Org](importing/) for guidance on
importing existing resources into Terraform state.

## Example tfvars

See the [Reference](../reference/) page for a full annotated example. The
[examples/pipeline](https://github.com/primeharbor/org-kickstart/tree/main/examples/pipeline)
directory in the repository contains a sample private-repo layout for CI/CD deployments.
