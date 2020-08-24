[![Maintained by Hentsu](https://img.shields.io/badge/maintained%20by-hentsu-%23FABA1E.svg)](https://hentsu.com/?ref=ghrepo_terraform-acme-tls-cert)

# Terraform Module for Generating ACME Let's Encrypt TLS Certificates

This repo provides a Terraform module to interact with [ACME Let's Encrypt](https://letsencrypt.org/) and generate TLS certificates on the fly.

The primary use of this is to use these certificates within other Terraform deployed infrastructure.

## How do you use this module?

### Terraform
Use the Terraform module syntax to download the module code:
```hcl
module "tls-cert" {
  source = "github.com/hentsu/terraform-acme-tls-cert"
}
```

### Terragrunt
Use Terragrunt to download the module code:
```hcl
# Use Terragrunt to download the module code
terraform {
  source = "git::git@github.com/hentsu/terraform-acme-tls-cert.git"
}

# Fill in the variables for that module
inputs = {
  acme_env      = "production"
  email_address = "someone@example.com"
  ...
}
```

When sourcing this module provide the following inputs:
* acme_env
* acme_version
* email_address
* common_name
* dns_provider
* dns_provider_user
* dns_provider_key

# Troubleshooting

## ACME Certificate Taking Too Long

Generating a certificate could result in very long times:
```
acme_certificate.tls: Still creating... [23m20s elapsed]
acme_certificate.tls: Still creating... [23m30s elapsed]
acme_certificate.tls: Still creating... [23m40s elapsed]
acme_certificate.tls: Still creating... [23m50s elapsed]
```

This could be down to rate limits from ACME or your DNS challenge provider. Check the number of calls to the production ACME server URL, or switch to staging, and check rate limits on your DNS challenge provider.

## Error 403 / Unauthorised from ACME

The following error may arise when re-running previously failed Terraform deployments:
```
Error: acme: error: 403 :: POST :: https://acme-v02.api.letsencrypt.org/acme/new-acct :: urn:ietf:params:acme:error:unauthorized :: An account with the provided public key exists but is deactivated, url:
```

This is mostly likely caused when Terraform is running multiple configuration steps of which the ACME certificate generation is one of them, and some other step causes a partial deployment of all the resources. There is likely a conflict, delete from state all the relevant ACME resources and try again.

