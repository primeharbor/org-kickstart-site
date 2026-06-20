---
title: Releases
description: How Org Kickstart is versioned — the latest branch and tagged releases — and how to pin the module source.
weight: 11
---

Org Kickstart uses a simple versioning model: a rolling `latest` branch and fixed, tagged releases.

We target **quarterly releases**, but may cut a new version sooner when significant new AWS
organization-management features warrant it.

## The `latest` branch

The default branch is **`latest`**. It always holds the most recent changes. Point your module
`source` at it (with no `?ref=`) to track the newest code:

```hcl
module "organization" {
  source = "github.com/primeharbor/org-kickstart"
  # ...
}
```

Use this if you want the newest features and are comfortable reviewing every `terraform plan` for
changes before you apply.

## Tagged releases

Each release is a fixed, immutable git tag — for example **`0.3.0`**. Pin to a tag for a stable,
reproducible deployment:

```hcl
module "organization" {
  source = "github.com/primeharbor/org-kickstart?ref=0.3.0"
  # ...
}
```

The [`examples/local-deploy`](https://github.com/primeharbor/org-kickstart/tree/0.3.0/examples/local-deploy)
sample pins to the current release by default. Bump the `?ref=` value when you're ready to move to a
newer release — and read its release notes for breaking changes first.

## Release notes

Per-release changes — new features, breaking changes, and migration steps — are published as
[release notes on the blog](/blog/releases/), and in each release's `docs/v<version>-notes.md` file
in the repository.

## Which should I use?

- **Production:** pin to a tagged release (`?ref=0.3.0`) and upgrade deliberately after reviewing
  the release notes.
- **Evaluating or lab environments:** track `latest` for the newest capabilities.
