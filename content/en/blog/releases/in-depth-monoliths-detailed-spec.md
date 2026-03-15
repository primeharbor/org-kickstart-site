---
title: Migrating from Region-Based Providers
date: 2025-06-01
description: >
  Guide for migrating security services from the legacy region-based provider pattern
  to the new region variable approach introduced in AWS Provider 6.x.
---

With the introduction of the `region` variable in the 6.x version of the AWS Terraform Provider,
the previous approach of using dedicated per-region provider blocks for security services is no
longer needed.

## What Changed

Previously, Org Kickstart used `generate_regionblocks.sh` to generate separate provider
configurations for each AWS region. The 6.x provider now accepts a `region` variable directly,
eliminating this requirement.

## Migration Steps

Generate `moved` blocks to tell Terraform where the resources have moved:

```bash
#!/bin/bash

> moves.tf
REGIONS=$(aws ec2 describe-regions | jq -r '.Regions[].RegionName')

for r in $REGIONS ; do
  cat <<EOF >> moves.tf

# $r
moved {
  from = module.security-services-$r.aws_guardduty_detector.payer_detector[0]
  to   = module.organization.module.security-services["$r"].aws_guardduty_detector.payer_detector[0]
}
moved {
  from = module.security-services-$r.aws_guardduty_detector.security_detector[0]
  to   = module.organization.module.security-services["$r"].aws_guardduty_detector.security_detector[0]
}
EOF
done
```

Run `terraform plan` after generating `moves.tf` to verify the migration looks correct before applying.

See the [full release notes](https://github.com/primeharbor/org-kickstart/blob/main/docs/v0.3.0-notes.md)
for the complete list of renamed resources.
