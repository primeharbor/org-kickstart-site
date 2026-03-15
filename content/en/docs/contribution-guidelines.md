---
title: Contribution Guidelines
description: How to contribute to Org Kickstart
weight: 10
---

We welcome contributions to both the Terraform module and this documentation site.
All submissions require review via GitHub pull request.

## Contributing to the Module

1. Fork the [org-kickstart repo](https://github.com/primeharbor/org-kickstart) on GitHub
2. Create a feature branch
3. Make your changes and test them against a real AWS Organization (see the CLAUDE.md for testing guidance)
4. Send a pull request with a clear description of the change and why it's needed

### Testing

When modifying the module:

- Use `terraform plan` extensively before apply
- Test in a non-production organization first
- Use targeted applies for risky changes: `terraform apply -target <resource>`
- Verify SCPs don't lock out root or prevent remediation

## Contributing to the Docs

The documentation source lives in the `org-kickstart-site/` directory alongside the module.

### Running the Site Locally

Requirements:
- **Hugo extended** >= 0.155.0
- **Node.js** (for PostCSS/SCSS processing)

```bash
cd org-kickstart-site
npm install
hugo server
```

The site will be available at `http://localhost:1313/`.

### Editing Pages

1. Fork the [org-kickstart repo](https://github.com/primeharbor/org-kickstart)
2. Edit files under `org-kickstart-site/content/en/`
3. Preview locally with `hugo server`
4. Submit a pull request

You can also click **Edit this page** in the top right of any documentation page to
jump directly to the source file on GitHub.

## Creating an Issue

Found a bug or want to request a feature? Open an issue on
[GitHub](https://github.com/primeharbor/org-kickstart/issues).

## Useful Resources

- [Docsy user guide](https://www.docsy.dev/docs/)
- [Hugo documentation](https://gohugo.io/documentation/)
- [Terraform AWS Provider docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
