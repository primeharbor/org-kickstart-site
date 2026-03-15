---
title: Overview
description: What Org Kickstart is and why you'd use it.
weight: 1
---

## What is Org Kickstart?

Org Kickstart is an opinionated Terraform module for bootstrapping and managing AWS Organizations.
It is PrimeHarbor's alternative to AWS Control Tower — designed to give you the good parts of a
landing zone without the cost, complexity, and lock-in that Control Tower brings.

Deployed into a brand new AWS Management (Payer) account, a single `terraform apply` will stand up
a fully governed AWS Organization with security services enabled, organizational guardrails in place,
and an account factory ready to provision new accounts.

![Org Kickstart Architecture](/images/KickControlTower.png)

## Why not just use Control Tower?

Control Tower is a massive beast designed to support highly regulated enterprises. For most
organizations, it brings significant drawbacks:

- **Expensive**: Heavy reliance on AWS Config means costs scale with the number of accounts and regions.
- **Inflexible**: Modifications require navigating AWS Service Catalog customizations.
- **Slow to update**: Features like Organization CloudTrail and GuardDuty Delegated Admin lagged behind
  AWS best practices for years.
- **Complex**: You effectively need a PhD in AWS Service Catalog to change anything.

Most organizations deploy Control Tower because their AWS Solutions Architect recommended it, or because
they needed an account factory. Org Kickstart gives you the account factory, the security posture, and
the governance — without the baggage.

## What Org Kickstart does

Org Kickstart deploys and manages:

1. **Security Account** — Delegates GuardDuty, Macie, Inspector, Security Hub, SSO, and CloudFormation
   StackSets to a dedicated Security Account. Configures all security services in every default region
   across all accounts.
2. **CloudTrail** — Creates a CloudTrail bucket in the Security Account and enables an Organizations
   CloudTrail in the Management Account.
3. **Alternate Contacts** — Sets Billing, Operations, and Security contacts for all AWS accounts.
4. **Organizational Units** — Creates four default OUs (Workloads, Governance, Sandbox, Suspended)
   plus any custom OUs you define.
5. **AI Opt-Out Policy** — Creates and applies a default AI opt-out policy at the root OU.
6. **Account Management** — Manages AWS accounts and OU placement from Terraform.
7. **Audit Role** — Deploys an Audit Role via CloudFormation StackSet to all accounts, trusting
   the Security Account.
8. **Billing Reports** — Creates an S3 bucket for billing data and an Athena-compatible CUR report.
9. **Organization Services** — Enables all important AWS Organization Integrated Services.
10. **Org Policies** — Manages Service Control Policies, Declarative Policies, and Resource Control
    Policies with Terraform templating support.
11. **SSO / Identity Center** — Creates an `AdministratorAccess` Permission Set, an admin group,
    and assigns both to every account.

## What is required vs. optional?

**Cannot be disabled:**
- Security Account
- Four default OUs (Governance, Workloads, Sandbox, Suspended)
- AI Opt-Out Policy
- Core Organization Integrated Services

**Can be disabled via variables:**
- CloudTrail management: `cloudtrail_bucket_name = null`
- SSO management: `disable_sso_management = true`
- Audit Role StackSet: `deploy_audit_role = false`
- Security services: `security_services` object with `disable_*` flags
- CUR reports: `cur_report_frequency = "NONE"`
- Alternate contacts: omit contact blocks from tfvars

## Where should I go next?

- [Getting Started](../getting-started/) — Bootstrap your account and run your first deploy
- [Reference](../reference/) — Full variable and policy reference
