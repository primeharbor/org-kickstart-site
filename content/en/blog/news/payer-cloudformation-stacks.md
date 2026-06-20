---
title: Payer-Account CloudFormation, Managed from Org Kickstart
date: 2026-06-08
description: >
  The new payer_cloudformation_stacks variable deploys arbitrary CloudFormation
  stacks into the management account, so payer-scoped automation can live in
  the same Terraform config as the rest of your org.
author: '[Chris Farris](https://www.chrisfarris.com)'
draft: false
---

Some automation only works in the management/payer account. Cost Explorer alarms, organization-wide billing notifications, anything that has to read `AWS::Billing` data or talk to the Organizations API as the master account. That stuff doesn't fit in a workload account, and it doesn't fit in the security account either.

Until now, the answer was "click that CloudFormation in by hand" or "stand up a second Terraform config just for the payer." Both options suck.

Org Kickstart now has a `payer_cloudformation_stacks` variable. Drop a map entry, point it at a template (local file or S3 URL), pick your regions, set your parameters. The next apply deploys it into the payer.

## Example

```hcl
payer_cloudformation_stacks = {
  billing_alerts = {
    stack_name    = "slack_billing_alerts"
    template_file = "cloudformation/slack-Template.yaml"
    regions       = ["us-east-1"]
    parameters = {
      pExecutionRate = "cron(0 09 * * ? *)"
      pEventInput = <<-EOT
        {
          "threshold": "10",
          "alert_percent": "20"
        }
      EOT
      pSlackWebhookSecret = "SlackWebHook"
      pRuleState          = "ENABLED"
      pAccountDescription = "My-Payer"
    }
  }
}
```

A few things worth knowing:

- **Composite resource addresses.** Each stack-region pair becomes `aws_cloudformation_stack.payer["<key>-<region>"]` (e.g., `billing_alerts-us-east-1`). Add a second region later and the existing stack doesn't get renamed.
- **`template_file` vs `template_url`.** Exactly one per stack. `template_file` is a local path relative to your tfvars repo root. `template_url` is an HTTPS or S3 URL.
- **`regions` is optional.** Omit it and the stack deploys only in the base org-kickstart region.
- **Capabilities are baked in.** Every stack gets `CAPABILITY_IAM`, `CAPABILITY_NAMED_IAM`, and `CAPABILITY_AUTO_EXPAND`. If you want stricter capabilities, this isn't the feature for you.
- **JSON parameter values are canonicalized.** CloudFormation parameter values are strings, and tfvars heredocs always end in a newline. Without normalization, every plan would show drift on JSON-string parameters. The module runs each value through `jsondecode | jsonencode` so the literal you write in tfvars matches what CFN stores. Non-JSON strings pass through unchanged.

See the [parameter reference](/docs/reference/parameter-reference/) for the full schema and an [example tfvars](/docs/getting-started/example-tfvars/) for context.
