---
title: About Org Kickstart
linkTitle: About
description: A Terraform module for governing AWS Organizations — by PrimeHarbor Technologies.
menu: { main: { weight: 10 } }
---

{{% blocks/cover
  title="About Org Kickstart"
  height="auto td-below-navbar"
  image_anchor="bottom"
%}}

<!-- prettier-ignore -->
{{% _param description %}}
{.display-6}

{{% /blocks/cover %}}

{{% blocks/lead color="white" %}}

**Org Kickstart** is an open-source Terraform module created by
[Chris Farris](https://www.chrisfarris.com) at
[PrimeHarbor Technologies](https://www.primeharbor.com).

It is designed to give AWS practitioners a production-grade organizational landing zone
without the overhead of AWS Control Tower. Deploy security services, account governance,
and organizational guardrails from a single Terraform module.

{{% /blocks/lead %}}

{{% blocks/section type="row" color="primary" %}}

{{% blocks/feature title="Open Source" icon="fab fa-github"
  url="https://github.com/primeharbor/org-kickstart"
%}}

Org Kickstart is licensed under the **Apache 2.0** license. Source code, issues, and
contributions are all managed on GitHub.

{{% /blocks/feature %}}

{{% blocks/feature title="By PrimeHarbor" icon="fa-solid fa-building"
  url="https://www.primeharbor.com"
%}}

PrimeHarbor Technologies provides cloud security consulting and tooling for AWS practitioners.
Professional support and implementation services are available.

{{% /blocks/feature %}}

{{% blocks/feature title="Prior Art" icon="fa-solid fa-book" %}}

Org Kickstart builds on the community's work. See also:
[terraform-aws-personal-org](https://github.com/george-richardson/terraform-aws-personal-org) and
[terraform-aws-organzation-and-sso](https://github.com/chris-qa-org/terraform-aws-organzation-and-sso).

{{% /blocks/feature %}}

{{% /blocks/section %}}

{{% blocks/section type="h4" color="white" %}}

## License

Copyright 2023 Chris Farris / PrimeHarbor Technologies, LLC

Licensed under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).

{{% /blocks/section %}}
