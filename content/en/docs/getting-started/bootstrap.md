---
title: Bootstrap a New Account
description: Manual steps required in the AWS Console before running Terraform.
weight: 1
---

Before Org Kickstart can be deployed, a few steps must be completed via ClickOps in your new AWS
Management (Payer) account. Terraform cannot perform these actions automatically.

## Root Account Tasks

Log into the **root** user of your new AWS "payer" account and complete the following:

1. [Add MFA to root](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/security_credentials)
2. [Enable IAM access to billing](https://us-east-1.console.aws.amazon.com/billing/home?region=us-east-1#/account)
3. Go to [Organizations](https://us-east-1.console.aws.amazon.com/organizations/v2/home) and **create an Organization**
4. Go to [AWS IAM Identity Center (SSO)](https://us-east-1.console.aws.amazon.com/singlesignon/home) and **enable it**
5. [Add yourself as a user](https://us-east-1.console.aws.amazon.com/singlesignon/home) in Identity Center
6. [Create a Permission Set](https://us-east-1.console.aws.amazon.com/iamv2/home#/organization/permission-sets/create) named **`TempAdministratorAccess`** (4-hour session recommended)
7. [Assign the Permission Set](https://us-east-1.console.aws.amazon.com/iamv2/home#/organization/accounts) to the Payer/Management Account for your user
8. [Activate trusted access for CloudFormation StackSets](https://us-east-1.console.aws.amazon.com/cloudformation/home#/stacksets) — click *"Activate trusted access with AWS Organizations to use service-managed permissions"* (must be done via console)

> **Log out of root and never use it again.**

> **Note:** As of June 2026, `aws login` works for the **root** user with Terraform — but the
> root user **cannot assume IAM roles**, and Org Kickstart assumes roles (for example
> `OrganizationAccountAccessRole` into the security account). That is why you must run Terraform as
> an IAM Identity Center user or an IAM User rather than as root.

## On Your Machine

1. Check email and activate your IAM Identity Center account
2. Add MFA to your Identity Center account
3. Configure AWS credentials in your environment:
   ```bash
   aws configure sso
   # or
   export AWS_PROFILE=your-sso-profile
   ```
4. Create the S3 bucket that will hold the Terraform state. It must exist before the first
   `terraform init`, since the S3 backend lives in it:
   ```bash
   aws s3 mb s3://org-kickstart-fooli
   ```
   This is the bucket you set as `backend_bucket`. By default (`manage_state_bucket = true`) Org
   Kickstart then adopts it into Terraform and enforces versioning, public-access-block, and
   encryption — see the [Parameter Reference](../../reference/parameter-reference/#state-bucket).

You are now ready to deploy Org Kickstart.

## Next Steps

- Create your `tfvars` file — see the [Reference](../../reference/) for all variables and a full example
- Run `terraform init` and your first apply — see [Getting Started](..)
