---
title: Org Kickstart
description: Kickstart and manage your AWS Organization with Terraform <br> Because friends don't let friends run Control Tower
params:
  body_class: td-navbar-links-all-active
---

{{% blocks/cover
  title="AWS Org Kickstart"
  height="full td-below-navbar"
  image_anchor="top"
%}}

<!-- prettier-ignore -->
{{% _param description %}}
{.display-6}

<!-- prettier-ignore -->
<div class="td-cta-buttons my-5">
  <a {{% _param btn-lg primary %}} href="docs/getting-started/">
    Get Started
  </a>
  <a {{% _param btn-lg secondary %}}
    href="{{% param github_project_repo %}}"
    target="_blank" rel="noopener noreferrer">
    View on GitHub
    {{% _param FA brands github "" %}}
  </a>
</div>

{{% blocks/link-down color="info" %}}

{{% /blocks/cover %}}

{{% blocks/lead color="white" %}}

**Org Kickstart** is an opinionated Terraform module for bootstrapping and governing AWS Organizations.
It delivers the good parts of Control Tower — security services, account factory, and guardrails — without
the AWS Config cost, Service Catalog complexity, or lock-in.

Deploy a fully governed AWS Organization from a single `terraform apply`.

{{% /blocks/lead %}}

{{% blocks/section color="primary" type="row" %}}

{{% blocks/feature title="Security by Default" icon="fa-shield-halved" %}}

Automatically delegates and configures **GuardDuty**, **Security Hub**, **Inspector**, and **Macie**
across every region and every account in your organization.

{{% /blocks/feature %}}

{{% blocks/feature
  title="Policy as Code" icon="fa-file-code"
  url="docs/tasks/creating-policies/"
%}}

Manage **Service Control Policies**, **Resource Control Policies**, and **Declarative Policies**
from Terraform, with templating support for org-specific variables.

{{% /blocks/feature %}}

{{% blocks/feature
  title="Account Factory" icon="fab fa-aws"
  url="docs/tasks/adding-an-account/"
%}}

Add an account to a tfvars file and get a fully configured AWS account in the right OU, with SSO
access, budgets, and alternate contacts.

{{% /blocks/feature %}}

{{% /blocks/section %}}

{{% blocks/section color="white" type="row" %}}

{{% blocks/feature title="Designed for Practitioners" icon="fa-users" %}}

No PhD in AWS Service Catalog required. Org Kickstart is built by practitioners, for practitioners
who need a production-grade landing zone — not a bloated compliance framework.

{{% /blocks/feature %}}

{{% blocks/feature title="Open Source" icon="fab fa-github"
  url="https://github.com/primeharbor/org-kickstart"
%}}

Apache 2.0 licensed and developed in the open on GitHub.
Contributions and bug reports are always welcome.

{{% /blocks/feature %}}

{{% blocks/feature title="Cost Conscious" icon="fa-dollar-sign" %}}

Unlike Control Tower, Org Kickstart does **not** require AWS Config in every account and region.
Deploy comprehensive security governance without the runaway Config costs.

{{% /blocks/feature %}}

{{% /blocks/section %}}

{{% blocks/section color="secondary" type="row text-center" %}}

### Ready to kickstart your AWS Organization?

<div class="mt-4">
  <a {{% _param btn-lg primary %}} href="docs/getting-started/">
    Read the Docs
  </a>
  <a {{% _param btn-lg light %}}
    href="https://github.com/primeharbor/org-kickstart"
    target="_blank" rel="noopener noreferrer">
    Star on GitHub
    {{% _param FA brands github "" %}}
  </a>
</div>

{{% /blocks/section %}}
