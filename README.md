# Org Kickstart — Documentation Site

This is the source for **[aws-kickstart.org](https://aws-kickstart.org)**, the official documentation website
for [org-kickstart](https://github.com/primeharbor/org-kickstart) — an opinionated Terraform module for
bootstrapping and governing AWS Organizations.

> *Friends don't let friends run Control Tower.*

---

## What is Org Kickstart?

[Org Kickstart](https://github.com/primeharbor/org-kickstart) is PrimeHarbor's open-source alternative to
AWS Control Tower. A single `terraform apply` into a new AWS Management (Payer) account delivers:

- **Security by default** — GuardDuty, Security Hub, Inspector, and Macie delegated and configured across every region and account
- **Policy as Code** — Service Control Policies, Resource Control Policies, and Declarative Policies managed from Terraform
- **Account Factory** — Add an account to a tfvars file; get a fully configured AWS account in the right OU with SSO access, budgets, and alternate contacts
- **No runaway Config costs** — Unlike Control Tower, Org Kickstart does not require AWS Config in every account and region

Apache 2.0 licensed and developed in the open on GitHub.

---

## About This Repository

This directory (`org-kickstart-site/`) contains the Hugo source for the documentation website. It is built
with [Hugo](https://gohugo.io/) (extended) and the [Docsy](https://www.docsy.dev/) theme.

```
org-kickstart-site/
├── hugo.yaml          # Site configuration
├── content/en/        # All page content (Markdown)
│   ├── docs/          # Documentation
│   ├── blog/          # News and release notes
│   └── community/     # Community page
├── static/images/     # Static images and diagrams
└── assets/scss/       # Custom styles
```

---

## Running the Site Locally

### Prerequisites

- **Hugo extended** ≥ 0.155.0 — [installation guide](https://www.docsy.dev/docs/get-started/docsy-as-module/installation-prerequisites/#install-hugo)
- **Go** ≥ 1.12 — [golang.org/dl](https://golang.org/dl/)
- **Node.js** (any recent LTS) — for PostCSS/SCSS compilation

### Steps

```bash
# Clone the repo
git clone https://github.com/primeharbor/org-kickstart-site.git
cd org-kickstart/org-kickstart-site

# Install Node dependencies (first time only)
make npm

# Start the local dev server (opens http://localhost:1319/ automatically)
make test

# To also render drafts and future-dated content
make test-drafts

# Build the static site to public/
make build-static
```

The dev server runs on **port 1319** with live reload on every file save.

---

## Contributing

We welcome contributions from the community — both to the Terraform module and to this documentation site.

### Contributing to the Docs

1. Fork the [org-kickstart repo](https://github.com/primeharbor/org-kickstart) on GitHub
2. Edit files under `org-kickstart-site/content/en/`
3. Preview locally with `hugo server`
4. Submit a pull request with a clear description of your change

Every page on the live site has an **Edit this page** link in the top right that takes you directly to the
source file on GitHub.

### Contributing to the Module

See [Contribution Guidelines](https://aws-kickstart.org/docs/contribution-guidelines/) on the docs site,
or the [contribution-guidelines.md](content/en/docs/contribution-guidelines.md) source file.

### Reporting Issues

- 🐛 **Bugs & feature requests**: [GitHub Issues](https://github.com/primeharbor/org-kickstart/issues)
- 💬 **Questions & ideas**: [GitHub Discussions](https://github.com/primeharbor/org-kickstart/discussions)

---

## License

Copyright © 2023–present [Chris Farris](https://www.chrisfarris.com) /
[PrimeHarbor Technologies, LLC](https://www.primeharbor.com).
Licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).

<!-- cSpell:ignore hugo docsy primeharbor kickstart -->
