module "example-tlscert" {
  source = "../../"

  acme_env          = "staging"
  email_address     = var.email_address
  common_name       = var.hostname
  dns_provider      = "namecheap"
  dns_provider_user = var.namecheap_api_user
  dns_provider_key  = var.namecheap_api_key
}