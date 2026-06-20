---
title: Set Up Your Local Repository
description: Create your private deployment repo from the local-deploy sample and learn the Makefile workflow.
weight: 2
---

Once the [Bootstrap](../bootstrap/) steps are complete, set up a private repository to hold your
organization's configuration and deploy Org Kickstart from your workstation.

## 1. Copy the sample

Copy the [`examples/local-deploy`](https://github.com/primeharbor/org-kickstart/tree/0.3.1/examples/local-deploy)
directory into your own **private** git repository. It provides:

- `main.tf` — calls the Org Kickstart module
- `import.tf` — adopts the AWS Organization, the payer account, and the state bucket
- `Makefile` — the `env`-based workflow (below)
- `sample.tfvars` / `sample.tfbackend` — templates to copy
- `scripts/` and `granted.yml` — helper scripts and the Granted registry manifest

## 2. Pin the module version

`main.tf` pins the module to a tagged release:

```hcl
source = "github.com/primeharbor/org-kickstart?ref=0.3.1"
```

See [Releases](../../releases/) for tracking the rolling `latest` branch versus pinning to a tag.

## 3. Create your environment files

Pick a short environment name (`$env`) for your org — for example `fooli`. Copy the samples so their
names match it:

```bash
cp sample.tfvars    fooli.tfvars
cp sample.tfbackend fooli.tfbackend
```

- Edit `fooli.tfvars` — see the [Parameter Reference](../../reference/parameter-reference/) and the
  [Example tfvars](../example-tfvars/) for all options.
- Set the state bucket name in `fooli.tfbackend` — the bucket you created with `aws s3 mb` during
  [Bootstrap](../bootstrap/). By default (`manage_state_bucket = true`) Org Kickstart adopts and
  manages it.

## 4. The Makefile workflow

Every target takes `env=<your env>`:

```bash
make env=fooli tf-init      # terraform init with your backend config
make env=fooli tf-plan      # write a saved plan
make env=fooli tf-apply     # apply the saved plan and write outputs
make env=fooli tf-execute   # tf-plan followed by tf-apply
make env=fooli update       # tf-init + tf-execute — your day-to-day command
```

The first apply creates the organization structure, OUs, and the security account.

## Next steps

- [Granted Support](../../granted/) — generate AWS CLI profiles for your accounts and share them
  with your team.
- [Account Configurator](../../account-configurator/) — automatically harden new accounts on
  creation.
- Adopting an organization that already exists? See
  [Importing an Existing Organization](../importing/).
