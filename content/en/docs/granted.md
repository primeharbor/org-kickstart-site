---
title: Granted Support
description: Generate an AWS CLI / Granted config from your org and share it with your team as a Granted Registry.
weight: 7
---

[Granted](https://granted.dev) is a tool for quickly assuming roles across many AWS accounts via
IAM Identity Center (SSO). Org Kickstart can generate a ready-to-use AWS config from your
Terraform outputs, and your org-kickstart repo can double as a [Granted
Registry](https://granted.dev) so your whole team gets the same set of account profiles.

The examples below use an environment named `fooli`. Substitute your own `env` name throughout.

## Prerequisites

- [Granted is installed](https://granted.dev) (`brew install granted` or see the [Granted docs](https://granted.dev)).
- IAM Identity Center is enabled and your org has been deployed at least once, so a
  `terraform apply` has produced an `output-<env>.json` file. The generator reads the
  `account_map`, `sso_start_url`, `sso_region`, and `sso_role_name` outputs.

## Generating an AWS config with `make granted`

After an apply, run the `granted` Makefile target:

```bash
make env=fooli granted
```

This runs `scripts/generate_granted_config.sh` against `output-fooli.json` and writes an AWS CLI
config to `granted/aws-config`. The file contains one `sso-session` block plus one `profile` per
account in your organization:

```ini
[sso-session fooli-sso]
sso_start_url = https://fooli.awsapps.com/start
sso_region = us-east-1
sso_registration_scopes = sso:account:access

[profile fooli-payer]
sso_session    = fooli-sso
sso_account_id = 111111111111
sso_role_name  = AdministratorAccess

[profile fooli-sandbox]
sso_session    = fooli-sso
sso_account_id = 222222222222
sso_role_name  = AdministratorAccess
```

Profiles are named after the keys in your `accounts` map (plus the payer and security accounts), so
re-running `make granted` after adding accounts keeps the config in sync. Regenerate it any time the
account list changes.

Once the profiles are in your AWS config you can assume any account with Granted:

```bash
assume fooli-sandbox
# or log the whole SSO session in first
aws sso login --sso-session fooli-sso
```

## Sharing your repo as a Granted Registry

A Granted Registry lets everyone on the team pull the same account profiles straight from a git
repo — no copy/pasting config files. Since your org-kickstart repo already generates the config,
it's the natural place to host the registry.

1. **Confirm the `granted.yml` manifest.** The `examples/local-deploy` sample already ships one at the
   repo root pointing at the generated config, so there's nothing to create — just keep it. It
   looks like this:

   ```yaml
   awsConfig:
       - ./granted/aws-config
   ```

2. **Commit the generated config.** Run `make env=fooli granted` and commit both `granted.yml` and
   `granted/aws-config` to the repo. (Re-run and commit whenever accounts change.)

3. **Team members add the registry once:**

   ```bash
   granted registry add -n fooli-admin -u git@github.com:fooli/fooli-org-kickstart.git
   ```

   Granted clones the repo, reads `granted.yml`, and merges the referenced profiles into the user's
   `~/.aws/config`. From then on they can `assume fooli-payer`, `assume fooli-sandbox`, and so on.

4. **Stay current.** When the registry repo is updated, team members pull the latest profiles with:

   ```bash
   granted registry sync
   ```

> **Tip:** keep the registry in a private repo. The generated config contains AWS account IDs and
> your SSO start URL. Those aren't secrets on their own, but there's no reason to publish them.
