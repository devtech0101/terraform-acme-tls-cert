/*
* Terraform configuration. Rely on 0.12 syntax or higher, no support for earlier versions.
*/
terraform {
  required_version = ">= 0.12"
  experiments = [variable_validation]
}

/*
* Set up some local variables.
*/
locals {
  server_urls = {
    "production" = {
      "02" = "https://acme-v02.api.letsencrypt.org/directory"
    }
    "staging" = {
      "02" = "https://acme-staging-v02.api.letsencrypt.org/directory"
    }
  }
}

/*
* Set up the ACME provider.
*/
provider "acme" {
  server_url = local.server_urls[var.acme_env][var.acme_version]
}

/*
* Generate a private key which will be used for the ACME registration.
*/
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

/*
* Do the ACME registration, use the email address provided.
*/
resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.key.private_key_pem
  email_address   = var.email_address
}

/*
* With the key from the registration we can generate a new certificate.
*/
resource "acme_certificate" "tls" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.common_name

  # Warning!
  # For now, the only supported DNS challenge provider is Namecheap.
  dns_challenge {
    provider = var.dns_provider
    config = {
      NAMECHEAP_API_USER     = var.dns_provider_user
      NAMECHEAP_API_KEY      = var.dns_provider_key
      NAMECHEAP_TTL          = 3600
      NAMECHEAP_HTTP_TIMEOUT = 600
    }
  }
}