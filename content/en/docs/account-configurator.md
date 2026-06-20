---
title: Account Configurator
description: Deploy the pht-account-configurator so new accounts are automatically hardened on creation.
weight: 5
---

When AWS Organizations creates a new account, a number of AWS-recommended best practices are **not**
turned on by default. The [pht-account-configurator](https://github.com/primeharbor/pht-account-configurator)
is a Step Function + Lambda that listens for the "account created" EventBridge event and configures
each new account for you. Org Kickstart can deploy and manage it as an optional add-on.

## What it configures

Driven by a config file (see [below](#the-configuration-file)), the configurator can:

- Set a CIS-compliant IAM **password policy**.
- Enable account-wide **S3 Block Public Access**.
- Enable **EBS snapshot Block Public Access** in every enabled region.
- Enable **EBS default encryption** in every enabled region.
- **Delete the default VPCs** in every region (except regions you mark to preserve, and any VPC that
  still has an ENI in it).

Sections omitted from the config file are simply skipped.

## How Org Kickstart deploys it

Set the `account_configurator` block in your `organization` object. When present, Org Kickstart
creates a CloudFormation stack (`org-kickstart-account-configurator`) from the packaged template and
uploads your config file to the Terraform state bucket. Omit the block (or set it to `null`) to
disable the feature.

```hcl
account_configurator = {
  template                    = "https://s3.amazonaws.com/<state-bucket>/pht-account-configurator/AccountFactory-Template-Transformed-<version>.yaml"
  account_factory_config_file = "<env>-account-config.yaml"
}
```

| Field | Description |
|-------|-------------|
| `template` | S3 URL of the packaged configurator CloudFormation template. The `make account-configurator` target sets this for you. |
| `account_factory_config_file` | Path (relative to your repo root) to the YAML config file. Terraform uploads it to the state bucket; the Lambda reads it from there. |

## Setting it up

The configurator is maintained in its own repo and pulled into your Org Kickstart deployment repo as
a git submodule. The `examples/local-deploy` `Makefile` ships an `account-configurator` target that
does the rest.

1. **Add the submodule** (once):

   ```bash
   git submodule add git@github.com:primeharbor/pht-account-configurator.git pht-account-configurator
   ```

2. **Run the target.** Using an environment named `fooli`:

   ```bash
   make env=fooli account-configurator
   ```

   This will:
   - check out the submodule if needed;
   - seed `fooli-account-config.yaml` from the submodule's sample if you don't already have one;
   - `package` the configurator's CloudFormation template into your Org Kickstart state bucket; and
   - point `account_configurator.template` and `account_configurator.account_factory_config_file`
     in `fooli.tfvars` at the freshly packaged template and your config file.

3. **Review and deploy.** Edit `fooli-account-config.yaml` to taste, then apply as usual:

   ```bash
   make env=fooli tf-plan
   make env=fooli tf-apply
   ```

   Re-run `make env=fooli account-configurator` whenever you want to ship a new version of the
   Lambda/template; it repackages and updates the template URL, and the next apply rolls it out.

## The configuration file

`<env>-account-config.yaml` controls what the Lambda does. A full example:

```yaml
# Configure the IAM Password Policy per CIS Benchmarks
account_password_policy:
  update_account_password_policy: true
  password_policy:
      MinimumPasswordLength: 24
      RequireSymbols: True
      RequireNumbers: True
      RequireUppercaseCharacters: True
      RequireLowercaseCharacters: True
      AllowUsersToChangePassword: True
      MaxPasswordAge: 90
      PasswordReusePrevention: 24
      HardExpiry: False

# Delete Default VPCs
default_vpc:
  delete_default_vpc: true
  # Regions in this list will keep their default VPCs
  preserve_vpc_regions:
    - "us-east-1"
    - "eu-central-1"

# Enable Default Encryption of EBS in all enabled regions
enable_ebs_default_encryption: true

# Enable Block Public Access for EBS snapshots in all enabled regions
enable_ebs_block_public_access: true

# Enable Account Wide S3 Block Public Access
enable_account_s3_block_public_access:
    BlockPublicAcls: True
    IgnorePublicAcls: True
    BlockPublicPolicy: True
    RestrictPublicBuckets: true
```

## Running against existing accounts

The Step Function normally runs on account creation, but you can also
[trigger it manually](https://github.com/primeharbor/pht-account-configurator) against an existing
account. Be aware of two risks before doing so:

- Enabling account-wide S3 Block Public Access can break legitimately public S3 buckets.
- Enabling EBS default encryption may interact with existing custom KMS key configurations.

Pair S3 Block Public Access with an SCP that prevents accounts from disabling it, and route any
genuinely public content to a dedicated account.
