---
title: Concepts
description: Key concepts and architecture behind Org Kickstart.
weight: 4
---

## AWS Organizations Structure

Org Kickstart manages resources in two AWS accounts simultaneously using Terraform's
multi-provider pattern:

- **Management (Payer) Account** — Where Terraform runs. Contains the Organization,
  OUs, SCPs, RCPs, Declarative Policies, CloudTrail, and SSO/Identity Center.
- **Security Account** — A dedicated account that is Delegated Administrator for
  GuardDuty, Macie, Inspector, Security Hub, CloudFormation StackSets, and optionally SSO.

## Required Organizational Units

Four OUs are always created and cannot be disabled:

| OU | Purpose |
|----|---------|
| `Governance` | Security and payer accounts |
| `Workloads` | Production workload accounts |
| `Sandbox` | Development accounts with more freedom |
| `Suspended` | Accounts pending closure |

## Policy Types

AWS Organizations supports three types of preventive controls, all managed by Org Kickstart:

| Type | Abbreviation | Scope |
|------|-------------|-------|
| Service Control Policies | SCP | What IAM principals can do |
| Resource Control Policies | RCP | What can be done to resources |
| Declarative Policies | DP | Baseline configuration of AWS services (EC2 only) |

All three are defined using the same Terraform structure and support `.tftpl` templating.

## Security Services

Org Kickstart enables and configures the following security services across all default
AWS regions and all accounts in the organization:

- **GuardDuty** — Threat detection. Payer and Security account both run detectors.
- **Security Hub** — Aggregated security findings. Security Account is delegated admin.
- **Inspector** — Vulnerability management. Security Account is delegated admin.
- **Macie** — S3 data security. Security Account is delegated admin.

## Audit Role

A cross-account audit role is deployed to every account via CloudFormation StackSets.
The role trusts the Security Account, allowing centralized read access for security
tools and audits without needing IAM users in every account.

## Account Factory Pattern

New AWS accounts are defined in the `accounts` map in tfvars. The account module
handles everything automatically:

1. Creates the AWS Organizations account
2. Places it in the correct OU
3. Assigns SSO access (via Identity Center group and Permission Set)
4. Sets billing, operations, and security alternate contacts
5. Creates a budget with alert thresholds
6. Applies SCPs/RCPs/Declarative Policies inherited from the parent OU
