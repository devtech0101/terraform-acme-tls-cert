variable "acme_env" {
  description = "The Let's Encrypt environment to use, default to using production."
  type        = string
  default     = "production"

  validation {
    condition     = var.acme_env == "production" || var.acme_env == "staging"
    error_message = "The acme_env value can be only \"production\" or \"staging\". Default is \"production\" if omitted."
  }
}

variable "acme_version" {
  description = "The ACME version to use, default to using the latest."
  type        = string
  default     = "02"

  validation {
    condition     = var.acme_version == "01" || var.acme_version == "02"
    error_message = "The acme_version value can be only \"01\" for older API version or \"02\" for latest. Default is \"02\"  if omitted."
  }
}

variable "email_address" {
  description = "The email address to use when doing the ACME registration."
  type        = string

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$", var.email_address))
    error_message = "The email_address must be a valid email address."
  }
}

variable "common_name" {
  description = "The common name to use for the certificate."
  type        = string
}

variable "dns_provider" {
  description = "The DNS provider to use for the validation."
  type        = string
}

variable "dns_provider_user" {
  description = "The username to authenticate with the DNS provider."
  type        = string
  default     = ""
}

variable "dns_provider_key" {
  description = "The token, key or password to authenticate with the DNS provider."
  type        = string
  default     = ""
}